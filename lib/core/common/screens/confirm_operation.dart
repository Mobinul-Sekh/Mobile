// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';

class ConfirmOperation<B extends BlocBase<S>, S> extends StatelessWidget {
  final Widget confirmationPrompt;
  final String? dialogText;
  final GestureTapCallback? onConfirm;
  final void Function(BuildContext, S)? listener;
  final bool Function(S)? isLoading;

  const ConfirmOperation({
    Key? key,
    required this.confirmationPrompt,
    this.dialogText,
    this.onConfirm,
    this.listener,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: confirmationPrompt,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.lightGrey,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowBlack,
                      blurRadius: 7,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: BlocConsumer<B, S>(
                  listener: (context, state) {
                    if (listener != null) listener!(context, state);
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            dialogText ?? AppLocalizations.of(context)!.saveUp),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GradientButton(
                              onTap: () {
                                Navigator.of(context).maybePop();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                        color: Theme.of(context).errorColor),
                              ),
                            ),
                            GradientButton(
                              onTap: onConfirm,
                              gradient: AppGradients.primaryLinear,
                              child: _checkIsLoading(state)
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.save,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.button,
                                    ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _checkIsLoading(S state) {
    if (isLoading == null) {
      return false;
    } else {
      return isLoading!(state);
    }
  }
}
