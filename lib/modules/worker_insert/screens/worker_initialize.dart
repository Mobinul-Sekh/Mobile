import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:bitecope/widgets/underlined_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          child: Column(
            children: [
              const UnderlinedTitle(title: "Worker Details"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 54),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.caption,
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.ownerUsername,
                            ),
                            TextSpan(
                              text: " *",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(color: AppColors.orange1),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _ownerNameController,
                        focusNode: _ownerNameNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => _workerNameNode.requestFocus(),
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: formFieldDecoration(
                          context,
                          isDense: true,
                          suffixSvgPath: 'assets/images/owner_username.svg',
                        ),
                      ),
                      const SizedBox(height: 54),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.caption,
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.workerName,
                            ),
                            TextSpan(
                              text: " *",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(color: AppColors.orange1),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _workerNameController,
                        focusNode: _workerNameNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            _workerAddressNode.requestFocus(),
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: formFieldDecoration(
                          context,
                          isDense: true,
                          suffixSvgPath: 'assets/images/worker_name.svg',
                        ),
                      ),
                      const SizedBox(height: 54),
                      TextField(
                        controller: _workerAddressController,
                        focusNode: _workerAddressNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            _workerDescriptionNode.requestFocus(),
                        style: Theme.of(context).textTheme.bodyText2,
                        minLines: 1,
                        maxLines: 3,
                        decoration: formFieldDecoration(
                          context,
                          labelText:
                              AppLocalizations.of(context)!.workerAddress,
                          suffixIcon: Icons.location_on_outlined,
                        ),
                      ),
                      const SizedBox(height: 54),
                      TextField(
                        controller: _workerDescriptionController,
                        focusNode: _workerDescriptionNode,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                        style: Theme.of(context).textTheme.bodyText2,
                        minLines: 1,
                        maxLines: 6,
                        decoration: formFieldDecoration(
                          context,
                          labelText:
                              AppLocalizations.of(context)!.userDescription,
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              RoundedWideButton(
                child: GradientWidget(
                  gradient: AppGradients.primaryGradient,
                  child: Text(
                    AppLocalizations.of(context)!.confirm,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
