// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/core/common/components/form_field_decoration.dart';
import 'package:bitecope/core/common/components/required_field_label.dart';

class BuyerForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;
  final TextEditingController descriptionController;
  final FocusNode? nameNode;
  final FocusNode? phoneNumberNode;
  final FocusNode? addressNode;
  final FocusNode? descriptionNode;
  final LocaleString? nameError;
  final LocaleString? phoneNumberError;
  final LocaleString? addressError;
  final LocaleString? descriptionError;
  final BuyerFormMode formMode;

  const BuyerForm({
    Key? key,
    required this.nameController,
    required this.phoneNumberController,
    required this.addressController,
    required this.descriptionController,
    this.nameNode,
    this.phoneNumberNode,
    this.addressNode,
    this.descriptionNode,
    this.nameError,
    this.phoneNumberError,
    this.addressError,
    this.descriptionError,
    this.formMode = BuyerFormMode.display,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 36),
        requiredFieldLabel(
          context,
          labelText: AppLocalizations.of(context)!.buyerName,
        ),
        TextFormField(
          controller: nameController,
          focusNode: nameNode,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          readOnly: formMode != BuyerFormMode.create,
          autofocus: formMode == BuyerFormMode.create,
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
          focusNode: phoneNumberNode,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          readOnly: formMode != BuyerFormMode.create,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
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
          focusNode: addressNode,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          readOnly: formMode != BuyerFormMode.create,
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
          focusNode: descriptionNode,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          textInputAction: TextInputAction.done,
          readOnly: formMode == BuyerFormMode.display,
          autofocus: formMode == BuyerFormMode.edit,
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

enum BuyerFormMode {
  create,
  display,
  edit,
}
