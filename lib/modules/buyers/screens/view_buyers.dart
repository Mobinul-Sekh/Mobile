// Flutter imports:
import 'package:bitecope/modules/buyers/bloc/buyer_bloc.dart';
import 'package:bitecope/modules/buyers/models/buyer.dart';
import 'package:bitecope/modules/buyers/components/buyer_form.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/routes/route_names.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/components/block_button.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/core/common/screens/confirm_operation.dart';
import 'package:bitecope/core/common/screens/operation_notification.dart';

class ViewBuyer extends StatefulWidget {
  final Buyer buyer;

  const ViewBuyer({
    Key? key,
    required this.buyer,
  }) : super(key: key);

  @override
  _ViewBuyerState createState() => _ViewBuyerState();
}

class _ViewBuyerState extends State<ViewBuyer> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _addressController;
  late final TextEditingController _descriptionController;
  late final FocusNode _descriptionNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.buyer.name);
    _phoneNumberController =
        TextEditingController(text: widget.buyer.phoneNumber);
    _addressController = TextEditingController(text: widget.buyer.address);
    _descriptionController =
        TextEditingController(text: widget.buyer.description);
    _descriptionNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(
            icon: Icons.arrow_back_rounded,
            size: 28,
          ),
          title: UnderlinedTitle(
            title: AppLocalizations.of(context)!.buyerDetails,
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: BlocConsumer<BuyerBloc, BuyerState>(
            listener: (context, state) {
              _handleListen(context, state);
            },
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FixedColumnWidth(18),
                        2: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            _tableCell(
                              text: AppLocalizations.of(context)!.buyerID,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(),
                            _tableCell(
                              text: widget.buyer.id,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: BuyerForm(
                        nameController: _nameController,
                        phoneNumberController: _phoneNumberController,
                        addressController: _addressController,
                        descriptionController: _descriptionController,
                        descriptionNode: _descriptionNode,
                        formMode: _isEditing
                            ? BuyerFormMode.edit
                            : BuyerFormMode.display,
                      ),
                    ),
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state.authData!.userType == UserType.owner) {
                        return Padding(
                          padding: const EdgeInsets.all(18),
                          child: _getButtons(),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleListen(BuildContext context, BuyerState state) {
    if (state.buyerStatus == BuyerStatus.editValidated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<BuyerBloc>(),
              child: Builder(
                builder: (_context) => ConfirmOperation<BuyerBloc, BuyerState>(
                  confirmationPrompt: _editConfirmationPrompt(context),
                  onConfirm: () => _context.read<BuyerBloc>().editBuyer(),
                  listener: (context, state) {
                    if (state.buyerStatus == BuyerStatus.ready) {
                      Navigator.of(context).maybePop();
                    } else if (state.buyerStatus == BuyerStatus.done) {
                      Navigator.of(context).pushAndRemoveUntil(
                        _editSuccessPage(),
                        ModalRoute.withName(RouteName.buyers),
                      );
                    }
                  },
                  isLoading: (state) =>
                      state.buyerStatus == BuyerStatus.loading,
                ),
              ),
            );
          },
        ),
      );
    } else if (state.buyerStatus == BuyerStatus.deleteValidated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<BuyerBloc>(),
              child: Builder(
                builder: (_context) => ConfirmOperation<BuyerBloc, BuyerState>(
                  confirmationPrompt: _deleteConfirmationPrompt(context),
                  onConfirm: () => _context.read<BuyerBloc>().deleteBuyer(),
                  dialogText: AppLocalizations.of(context)!.removeBuyer,
                  flatButtonText: AppLocalizations.of(context)!.remove,
                  elevatedButtonText: AppLocalizations.of(context)!.no,
                  flipCallback: true,
                  listener: (context, state) {
                    if (state.buyerStatus == BuyerStatus.ready) {
                      Navigator.of(context).maybePop();
                    } else if (state.buyerStatus == BuyerStatus.done) {
                      Navigator.of(context).pushAndRemoveUntil(
                        _deleteSuccessPage(),
                        ModalRoute.withName(RouteName.buyers),
                      );
                    }
                  },
                  isLoading: (state) =>
                      state.buyerStatus == BuyerStatus.loading,
                ),
              ),
            );
          },
        ),
      );
    }
  }

  RichText _editConfirmationPrompt(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: AppColors.shadowText),
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.tryingTo,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.editBuyer,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.confirmOperation,
          ),
        ],
      ),
    );
  }

  RichText _deleteConfirmationPrompt(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: AppColors.shadowText),
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.tryingTo,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.deleteBuyer,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.confirmOperation,
          ),
        ],
      ),
    );
  }

  Route _editSuccessPage() {
    return MaterialPageRoute(
      builder: (context) {
        return OperationNotification(
          iconPath: "assets/images/circle_check.svg",
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.detailEdited,
          splashImagePath: "assets/images/change_confirmation.svg",
          nextText: AppLocalizations.of(context)!.backToBuyer,
          nextCallback: () {
            Navigator.of(context).maybePop();
          },
        );
      },
    );
  }

  Route _deleteSuccessPage() {
    return MaterialPageRoute(
      builder: (context) {
        return OperationNotification(
          iconPath: "assets/images/circle_delete.svg",
          title: AppLocalizations.of(context)!.deleted,
          message: AppLocalizations.of(context)!.detailEdited,
          splashImagePath: "assets/images/change_confirmation.svg",
          nextText: AppLocalizations.of(context)!.backToBuyer,
          nextCallback: () {
            Navigator.of(context).maybePop();
          },
        );
      },
    );
  }

  Widget _getButtons() {
    if (_isEditing) {
      return GradientButton(
        onTap: () {
          setState(() => _isEditing = false);
          context.read<BuyerBloc>().confirmEdit(
                buyerID: widget.buyer.id,
                description: _descriptionController.text,
              );
          _descriptionController.text = widget.buyer.description ?? "";
        },
        gradient: AppGradients.primaryLinear,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.confirm,
              style: Theme.of(context).textTheme.button,
            ),
            const SizedBox(width: 24),
            const Icon(
              Icons.check_circle,
              color: AppColors.white,
            )
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlockButton(
          onTap: () {
            setState(() => _isEditing = true);
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              _descriptionNode.requestFocus();
            });
          },
          position: BlockPosition.left,
          child: const Center(
            child: GradientWidget(
              gradient: AppGradients.primaryLinear,
              child: Icon(
                Icons.edit,
                size: 36,
              ),
            ),
          ),
        ),
        BlockButton(
          onTap: () {
            context.read<BuyerBloc>().confirmDelete(buyerID: widget.buyer.id);
          },
          position: BlockPosition.right,
          child: Center(
            child: SvgPicture.asset(
              'assets/images/delete.svg',
              width: 36,
              height: 36,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tableCell({
    required String text,
    TextStyle? style,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.lightGrey,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowBlack,
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }
}
