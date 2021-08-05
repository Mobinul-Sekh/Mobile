// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/core/common/screens/confirm_operation.dart';
import 'package:bitecope/core/common/screens/operation_notification.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_bloc.dart';
import 'package:bitecope/modules/suppliers/components/supplier_form.dart';

class AddSupplier extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddSupplier({Key? key}) : super(key: key);

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
            title: AppLocalizations.of(context)!.addSupplier,
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
                      child: SupplierForm(
                        nameController: _nameController,
                        nameError: state.name.error,
                        phoneNumberController: _phoneNumberController,
                        phoneNumberError: state.phoneNumber.error,
                        addressController: _addressController,
                        addressError: state.address.error,
                        descriptionController: _descriptionController,
                        descriptionError: state.description.error,
                        formMode: SupplierFormMode.create,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: GradientButton(
                      onTap: () {
                        context.read<SupplierBloc>().validateSupplier(
                              name: _nameController.text,
                              phoneNumber: _phoneNumberController.text,
                              address: _addressController.text,
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

  void _handleListen(BuildContext context, SupplierState state) {
    if (state.supplierStatus == SupplierStatus.createValidated) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<SupplierBloc>(),
              child: Builder(
                builder: (_context) =>
                    ConfirmOperation<SupplierBloc, SupplierState>(
                  confirmationPrompt: _confirmationPrompt(context),
                  onConfirm: () => _context.read<SupplierBloc>().addSupplier(),
                  listener: (context, state) {
                    if (state.supplierStatus == SupplierStatus.ready) {
                      Navigator.of(context).maybePop();
                    } else if (state.supplierStatus == SupplierStatus.done) {
                      Navigator.of(context).pushAndRemoveUntil(
                        _successPage(),
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
            text: AppLocalizations.of(context)!.addNewSupplier,
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
          nextText: AppLocalizations.of(context)!.backToSuppliers,
          nextCallback: () {
            Navigator.of(context).pushReplacementNamed('/suppliers');
          },
        );
      },
    );
  }
}
