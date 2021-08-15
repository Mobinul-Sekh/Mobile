// Flutter imports:

import 'package:bitecope/modules/warehouse/bloc/warehouse_bloc.dart';
import 'package:bitecope/modules/warehouse/components/warehouse_form.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/routes/route_names.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/core/common/screens/confirm_operation.dart';
import 'package:bitecope/core/common/screens/operation_notification.dart';

class AddWarehouse extends StatelessWidget {
  AddWarehouse({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

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
            title: AppLocalizations.of(context)!.addWarehouse,
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocConsumer<WarehouseBloc, WarehouseState>(
            listener: (context, state) {
              _handleListen(context, state);
            },
            builder: (context, state) {
              return Column(
                children: [
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
                      child: WarehouseForm(
                        nameController: _nameController,
                        nameError: state.name.error,
                        descriptionController: _descriptionController,
                        descriptionError: state.description.error,
                        formMode: WarehouseFormMode.create,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: GradientButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<WarehouseBloc>().validateWarehouse(
                              name: _nameController.text,
                              description: _descriptionController.text,
                            );
                      },
                      gradient: AppGradients.primaryLinear,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            AppLocalizations.of(context)!.confirm,
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleListen(BuildContext context, WarehouseState state) {
    if (state.warehouseStatus == WarehouseStatus.createValidated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<WarehouseBloc>(),
              child: Builder(
                builder: (_context) =>
                    ConfirmOperation<WarehouseBloc, WarehouseState>(
                  confirmationPrompt: _confirmationPrompt(context),
                  onConfirm: () =>
                      _context.read<WarehouseBloc>().addWarehouse(),
                  listener: (context, state) {
                    if (state.warehouseStatus == WarehouseStatus.ready) {
                      Navigator.of(context).maybePop();
                    } else if (state.warehouseStatus == WarehouseStatus.done) {
                      Navigator.of(context).pushAndRemoveUntil(
                        _successPage(),
                        (route) => route.isFirst,
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

  RichText _confirmationPrompt(BuildContext context) {
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
            text: AppLocalizations.of(context)!.addNewWarehouse,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.confirmOperation,
          ),
        ],
      ),
    );
  }

  Route _successPage() {
    return MaterialPageRoute(
      builder: (context) {
        return OperationNotification(
          iconPath: "assets/images/cloud_check.svg",
          title: AppLocalizations.of(context)!.saved,
          message: AppLocalizations.of(context)!.detailAdded,
          splashImagePath: "assets/images/astronaut_flag.svg",
          nextText: AppLocalizations.of(context)!.backToWarehouse,
          nextCallback: () {
            Navigator.of(context).pushReplacementNamed(RouteName.warehouses);
          },
        );
      },
    );
  }
}
