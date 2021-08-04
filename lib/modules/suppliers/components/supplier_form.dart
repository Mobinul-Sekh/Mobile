// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/core/common/components/form_field_decoration.dart';
import 'package:bitecope/core/common/components/required_field_label.dart';

class SupplierForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;
  final TextEditingController descriptionController;
  final LocaleString? nameError;
  final LocaleString? phoneNumberError;
  final LocaleString? addressError;
  final LocaleString? descriptionError;
  final SupplierFormMode formMode;

  const SupplierForm({
    Key? key,
    required this.nameController,
    required this.phoneNumberController,
    required this.addressController,
    required this.descriptionController,
    this.nameError,
    this.phoneNumberError,
    this.addressError,
    this.descriptionError,
    this.formMode = SupplierFormMode.display,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 36),
        requiredFieldLabel(
          context,
          labelText: AppLocalizations.of(context)!.supplierName,
        ),
        TextFormField(
          controller: nameController,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          enabled: formMode == SupplierFormMode.create,
          autofocus: formMode == SupplierFormMode.create,
          textInputAction: TextInputAction.next,
          decoration: formFieldDecoration(
            context,
            isDense: true,
            errorText: nameError != null ? nameError!(context) : null,
          ),
        ),
        const SizedBox(height: 36),
        requiredFieldLabel(
          context,
          labelText: AppLocalizations.of(context)!.phoneNumber,
        ),
        TextFormField(
          controller: phoneNumberController,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          enabled: formMode == SupplierFormMode.create,
          textInputAction: TextInputAction.next,
          decoration: formFieldDecoration(
            context,
            isDense: true,
            errorText:
                phoneNumberError != null ? phoneNumberError!(context) : null,
          ),
        ),
        const SizedBox(height: 36),
        requiredFieldLabel(
          context,
          labelText: AppLocalizations.of(context)!.address,
        ),
        TextFormField(
          controller: addressController,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          enabled: formMode == SupplierFormMode.create,
          textInputAction: TextInputAction.next,
          minLines: 1,
          maxLines: 3,
          decoration: formFieldDecoration(
            context,
            isDense: true,
            errorText: addressError != null ? addressError!(context) : null,
          ),
        ),
        const SizedBox(height: 36),
        requiredFieldLabel(
          context,
          labelText: AppLocalizations.of(context)!.description,
          isRequired: false,
        ),
        TextFormField(
          controller: descriptionController,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          textInputAction: TextInputAction.done,
          enabled: formMode == SupplierFormMode.create ||
              formMode == SupplierFormMode.edit,
          autofocus: formMode == SupplierFormMode.edit,
          minLines: 1,
          maxLines: 6,
          decoration: formFieldDecoration(
            context,
            isDense: true,
            errorText:
                descriptionError != null ? descriptionError!(context) : null,
          ),
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}

enum SupplierFormMode {
  create,
  display,
  edit,
}
