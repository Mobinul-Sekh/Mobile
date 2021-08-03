// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/modules/worker_initialize/bloc/worker_initialize_bloc.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/required_field_label.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:bitecope/widgets/underlined_title.dart';

class WorkerInitialize extends StatelessWidget {
  WorkerInitialize({Key? key}) : super(key: key);

  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _workerNameController = TextEditingController();
  final TextEditingController _workerAddressController =
      TextEditingController();
  final TextEditingController _workerDescriptionController =
      TextEditingController();

  final FocusNode _ownerNameNode = FocusNode();
  final FocusNode _workerNameNode = FocusNode();
  final FocusNode _workerAddressNode = FocusNode();
  final FocusNode _workerDescriptionNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocConsumer<WorkerInitializeBloc, WorkerInitializeState>(
            listener: (context, state) {
              if (state.workerInitializeStatus ==
                  WorkerInitializeStatus.initialized) {
                context.read<AuthenticationBloc>().setStatus();
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  UnderlinedTitle(
                    title: AppLocalizations.of(context)!.workerDetails,
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 18),
                    Text(
                      state.error!(context)!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Theme.of(context).errorColor),
                    ),
                  ],
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 36),
                          requiredFieldLabel(
                            context,
                            labelText:
                                AppLocalizations.of(context)!.ownerUsername,
                          ),
                          TextField(
                            controller: _ownerNameController,
                            focusNode: _ownerNameNode,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                _workerNameNode.requestFocus(),
                            style: Theme.of(context).textTheme.bodyText2,
                            decoration: formFieldDecoration(
                              context,
                              isDense: true,
                              errorText: state.ownerUsername.error != null
                                  ? state.ownerUsername.error!(context)
                                  : null,
                              suffixSvgPath: 'assets/images/owner_username.svg',
                            ),
                          ),
                          const SizedBox(height: 54),
                          requiredFieldLabel(
                            context,
                            labelText: AppLocalizations.of(context)!.workerName,
                          ),
                          TextField(
                            controller: _workerNameController,
                            focusNode: _workerNameNode,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                _workerAddressNode.requestFocus(),
                            style: Theme.of(context).textTheme.bodyText2,
                            decoration: formFieldDecoration(
                              context,
                              errorText: state.workerName.error != null
                                  ? state.workerName.error!(context)
                                  : null,
                              isDense: true,
                              suffixSvgPath: 'assets/images/worker_name.svg',
                            ),
                          ),
                          const SizedBox(height: 54),
                          requiredFieldLabel(
                            context,
                            labelText:
                                AppLocalizations.of(context)!.workerAddress,
                          ),
                          TextField(
                            controller: _workerAddressController,
                            focusNode: _workerAddressNode,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                _workerDescriptionNode.requestFocus(),
                            style: Theme.of(context).textTheme.bodyText2,
                            minLines: 1,
                            maxLines: 3,
                            decoration: formFieldDecoration(
                              context,
                              errorText: state.workerAddress.error != null
                                  ? state.workerAddress.error!(context)
                                  : null,
                              isDense: true,
                              suffixIcon: Icons.location_on_outlined,
                            ),
                          ),
                          const SizedBox(height: 54),
                          Text(
                            AppLocalizations.of(context)!.userDescription,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          TextField(
                            controller: _workerDescriptionController,
                            focusNode: _workerDescriptionNode,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.newline,
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            style: Theme.of(context).textTheme.bodyText2,
                            minLines: 2,
                            maxLines: 6,
                            decoration: formFieldDecoration(
                              context,
                              isDense: true,
                            ),
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _confirmButton(context, state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  RoundedWideButton _confirmButton(
    BuildContext context,
    WorkerInitializeState state,
  ) {
    return RoundedWideButton(
      onTap: state.workerInitializeStatus == WorkerInitializeStatus.initializing
          ? null
          : () {
              context.read<WorkerInitializeBloc>().validateWorkerInitialize(
                    ownerUsername: _ownerNameController.text,
                    workerName: _workerNameController.text,
                    workerAddress: _workerAddressController.text,
                    aboutYourself: _workerDescriptionController.text,
                  );
            },
      child: state.workerInitializeStatus == WorkerInitializeStatus.initializing
          ? const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(),
            )
          : GradientWidget(
              gradient: AppGradients.primaryLinear,
              child: Text(
                AppLocalizations.of(context)!.confirm,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
    );
  }
}
