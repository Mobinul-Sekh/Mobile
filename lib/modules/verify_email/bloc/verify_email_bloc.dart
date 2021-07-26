// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/verify_email/repositories/verify_email_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'verify_email_state.dart';

class VerifyEmailBloc extends Cubit<VerifyEmailState> {
  final VerifyEmailRepository _verifyEmailRepository;
  final int _timeoutDuration = 30;

  VerifyEmailBloc(this._verifyEmailRepository) : super(VerifyEmailState());

  void resendOTP() {
    //TODO Resend OTP
    if (state.timeout == null) {
      emit(state.copyWith(
        timeout: _timeoutDuration,
      ));
      _timerTick();
    }
  }

  void _timerTick() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(
          state.copyWith(timeout: state.timeout! - 1),
        );
        if (state.timeout != null) {
          _timerTick();
        }
      },
    );
  }
}
