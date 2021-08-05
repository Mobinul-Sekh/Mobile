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
  final String? flatButtonText;
  final String? elevatedButtonText;
  final bool flipCallback;
  final GestureTapCallback? onConfirm;
  final void Function(BuildContext, S)? listener;
  final bool Function(S)? isLoading;

  const ConfirmOperation({
    Key? key,
    required this.confirmationPrompt,
    this.dialogText,
    this.flatButtonText,
    this.elevatedButtonText,
    this.flipCallback = false,
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
                                _setCallback(
                                  context,
                                  _ButtonType.flatButton,
                                );
                              },
                              child: _setButtonChild(
                                context,
                                state,
                                _ButtonType.flatButton,
                              ),
                            ),
                            GradientButton(
                              onTap: () {
                                _setCallback(
                                  context,
                                  _ButtonType.elevatedButton,
                                );
                              },
                              gradient: AppGradients.primaryLinear,
                              child: _setButtonChild(
                                context,
                                state,
                                _ButtonType.elevatedButton,
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

  void _setCallback(
    BuildContext context,
    _ButtonType type,
  ) {
    switch (type) {
      case _ButtonType.flatButton:
        if (flipCallback) {
          return onConfirm != null ? onConfirm!() : null;
        } else {
          return _cancelCallback(context);
        }
      case _ButtonType.elevatedButton:
        if (flipCallback) {
          return _cancelCallback(context);
        } else {
          return onConfirm != null ? onConfirm!() : null;
        }
    }
  }

  Widget _setButtonChild(
    BuildContext context,
    S state,
    _ButtonType type,
  ) {
    final Widget _progressIndicator = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ),
      ],
    );
    final Widget _flatButtonText = Text(
      flatButtonText ??
          (flipCallback
              ? AppLocalizations.of(context)!.save
              : AppLocalizations.of(context)!.cancel),
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .button
          ?.copyWith(color: Theme.of(context).errorColor),
    );
    final Widget _elevatedButtonText = Text(
      elevatedButtonText ??
          (flipCallback
              ? AppLocalizations.of(context)!.cancel
              : AppLocalizations.of(context)!.save),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.button,
    );
    switch (type) {
      case _ButtonType.flatButton:
        if (flipCallback) {
          if (_checkIsLoading(state)) {
            return _progressIndicator;
          } else {
            return _flatButtonText;
          }
        } else {
          return _flatButtonText;
        }
      case _ButtonType.elevatedButton:
        if (flipCallback) {
          return _elevatedButtonText;
        } else {
          if (_checkIsLoading(state)) {
            return _progressIndicator;
          } else {
            return _elevatedButtonText;
          }
        }
    }
  }

  void _cancelCallback(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  bool _checkIsLoading(S state) {
    if (isLoading == null) {
      return false;
    } else {
      return isLoading!(state);
    }
  }
}

enum _ButtonType {
  flatButton,
  elevatedButton,
}
