// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/core/common/components/form_field_decoration.dart';
import 'package:bitecope/core/common/components/required_field_label.dart';

class WarehouseForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final FocusNode? nameNode;
  final FocusNode? descriptionNode;
  final LocaleString? nameError;
  final LocaleString? descriptionError;
  final WarehouseFormMode formMode;

  const WarehouseForm({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    this.nameNode,
    this.descriptionNode,
    this.nameError,
    this.descriptionError,
    this.formMode = WarehouseFormMode.display,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 36),
        requiredFieldLabel(
          context,
          labelText: AppLocalizations.of(context)!.warehouseName,
        ),
        TextFormField(
          controller: nameController,
          focusNode: nameNode,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          readOnly: formMode != WarehouseFormMode.create,
          autofocus: formMode == WarehouseFormMode.create,
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
          labelText: AppLocalizations.of(context)!.description,
          isRequired: false,
        ),
        TextFormField(
          controller: descriptionController,
          focusNode: descriptionNode,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2,
          textInputAction: TextInputAction.done,
          readOnly: formMode == WarehouseFormMode.display,
          autofocus: formMode == WarehouseFormMode.edit,
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

enum WarehouseFormMode {
  create,
  display,
  edit,
}
