// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/block_button.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/components/snackbar_message.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/core/common/screens/confirm_operation.dart';
import 'package:bitecope/core/common/screens/operation_notification.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_bloc.dart';
import 'package:bitecope/modules/suppliers/components/supplier_form.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';

class ViewSupplier extends StatefulWidget {
  final Supplier supplier;

  const ViewSupplier({
    Key? key,
    required this.supplier,
  }) : super(key: key);

  @override
  _ViewSupplierState createState() => _ViewSupplierState();
}

class _ViewSupplierState extends State<ViewSupplier> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _addressController;
  late final TextEditingController _descriptionController;
  late final FocusNode _descriptionNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.supplier.name);
    _phoneNumberController =
        TextEditingController(text: widget.supplier.phoneNumber);
    _addressController = TextEditingController(text: widget.supplier.address);
    _descriptionController =
        TextEditingController(text: widget.supplier.description);
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
            title: AppLocalizations.of(context)!.supplierDetails,
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocConsumer<SupplierBloc, SupplierState>(
            listener: (context, state) {
              _handleListen(context, state);
            },
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
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
                              text: AppLocalizations.of(context)!.supplierID,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(),
                            _tableCell(
                              text: widget.supplier.id,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SupplierForm(
                        nameController: _nameController,
                        phoneNumberController: _phoneNumberController,
                        addressController: _addressController,
                        descriptionController: _descriptionController,
                        descriptionNode: _descriptionNode,
                        formMode: _isEditing
                            ? SupplierFormMode.edit
                            : SupplierFormMode.display,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: _getButtons(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleListen(BuildContext context, SupplierState state) {
    if (state.supplierStatus == SupplierStatus.editValidated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<SupplierBloc>(),
              child: Builder(
                builder: (_context) =>
                    ConfirmOperation<SupplierBloc, SupplierState>(
                  confirmationPrompt: _editConfirmationPrompt(context),
                  onConfirm: () => _context.read<SupplierBloc>().editSupplier(),
                  listener: (context, state) {
                    if (state.supplierStatus == SupplierStatus.ready) {
                      Navigator.of(context).maybePop();
                    } else if (state.supplierStatus == SupplierStatus.done) {
                      Navigator.of(context).pushAndRemoveUntil(
                        _editSuccessPage(),
                        (route) => route.isFirst,
                      );
                    }
                  },
                  isLoading: (state) =>
                      state.supplierStatus == SupplierStatus.loading,
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
            text: AppLocalizations.of(context)!.editSupplier,
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
          nextText: AppLocalizations.of(context)!.backToSuppliers,
          nextCallback: () {
            Navigator.of(context).pushReplacementNamed('/suppliers');
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
          context.read<SupplierBloc>().confirmEdit(
                supplierID: widget.supplier.id,
                description: _descriptionController.text,
              );
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
            //TODO
            snackbarMessage(
              context,
              "Not Implemented",
              MessageType.warning,
            );
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
