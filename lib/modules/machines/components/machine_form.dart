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
          labelText: AppLocalizations.of(context)!.machineName,
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
      ],
    );
  }
}

enum MachineFormMode {
  create,
  display,
  edit,
}
