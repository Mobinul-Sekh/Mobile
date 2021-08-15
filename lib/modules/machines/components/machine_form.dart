// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/core/common/components/form_field_decoration.dart';
import 'package:bitecope/core/common/components/required_field_label.dart';

class MachineForm extends StatelessWidget {
  final TextEditingController nameController;
  final FocusNode? nameNode;
  final LocaleString? nameError;
  final MachineFormMode formMode;
  const MachineForm({
    Key? key,
    required this.nameController,
    this.nameNode,
    this.nameError,
    this.formMode = MachineFormMode.display,
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
          readOnly: formMode != MachineFormMode.create,
          autofocus: formMode == MachineFormMode.create,
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
          readOnly: formMode != MachineFormMode.create,
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
          readOnly: formMode != MachineFormMode.create,
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
          readOnly: formMode == MachineFormMode.display,
          autofocus: formMode == MachineFormMode.edit,
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

enum MachineFormMode {
  create,
  display,
  edit,
}
