// Flutter imports:

import 'package:bitecope/modules/warehouse/bloc/warehouse_bloc.dart';
import 'package:bitecope/modules/warehouse/components/warehouse_form.dart';
import 'package:bitecope/modules/warehouse/models/warehouse.dart';
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
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/core/common/screens/confirm_operation.dart';
import 'package:bitecope/core/common/screens/operation_notification.dart';

class ViewWarehouse extends StatefulWidget {
  final Warehouse warehouse;

  const ViewWarehouse({
    Key? key,
    required this.warehouse,
  }) : super(key: key);

  @override
  _ViewWarehouseState createState() => _ViewWarehouseState();
}

class _ViewWarehouseState extends State<ViewWarehouse> {
  late final TextEditingController _nameController;

  late final TextEditingController _descriptionController;
  late final FocusNode _descriptionNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.warehouse.name);

    _descriptionController =
        TextEditingController(text: widget.warehouse.description);
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
            title: AppLocalizations.of(context)!.warehouseDetails,
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: BlocConsumer<WarehouseBloc, WarehouseState>(
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
                              text: AppLocalizations.of(context)!.warehouseID,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(),
                            _tableCell(
                              text: widget.warehouse.id,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (state.error != null)
                    Text(
                      state.error!(context)!,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Theme.of(context).errorColor),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: WarehouseForm(
                        nameController: _nameController,
                        descriptionController: _descriptionController,
                        descriptionNode: _descriptionNode,
                        formMode: _isEditing
                            ? WarehouseFormMode.edit
                            : WarehouseFormMode.display,
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

  void _handleListen(BuildContext context, WarehouseState state) {
    if (state.warehouseStatus == WarehouseStatus.deleteValidated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<WarehouseBloc>(),
              child: Builder(
                builder: (_context) =>
                    ConfirmOperation<WarehouseBloc, WarehouseState>(
                  confirmationPrompt: _deleteConfirmationPrompt(context),
                  onConfirm: () =>
                      _context.read<WarehouseBloc>().deleteWarehouse(),
                  dialogText: AppLocalizations.of(context)!.removeWarehouse,
                  flatButtonText: AppLocalizations.of(context)!.remove,
                  elevatedButtonText: AppLocalizations.of(context)!.no,
                  flipCallback: true,
                  listener: (context, state) {
                    if (state.warehouseStatus == WarehouseStatus.ready) {
                      Navigator.of(context).maybePop();
                    } else if (state.warehouseStatus == WarehouseStatus.done) {
                      Navigator.of(context).pushAndRemoveUntil(
                        _deleteSuccessPage(),
                        ModalRoute.withName(RouteName.warehouses),
                      );
                    }
                  },
                  isLoading: (state) =>
                      state.warehouseStatus == WarehouseStatus.loading,
                ),
              ),
            );
          },
        ),
      );
    }
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
            text: AppLocalizations.of(context)!.deleteWarehouse,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.confirmOperation,
          ),
        ],
      ),
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
          nextText: AppLocalizations.of(context)!.backToWarehouse,
          nextCallback: () {
            Navigator.of(context).maybePop();
          },
        );
      },
    );
  }

  Widget _getButtons() {
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
            context
                .read<WarehouseBloc>()
                .confirmDelete(warehouseID: widget.warehouse.id);
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

    _descriptionController.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }
}
