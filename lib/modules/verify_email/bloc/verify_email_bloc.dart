// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/verify_email/models/resend_otp_response.dart';
import 'package:bitecope/modules/verify_email/models/verify_email_response.dart';
import 'package:bitecope/modules/verify_email/repositories/verify_email_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'verify_email_state.dart';

class VerifyEmailBloc extends Cubit<VerifyEmailState> {
  final VerifyEmailRepository _verifyEmailRepository;
  final int _timeoutDuration = 30;

  VerifyEmailBloc(this._verifyEmailRepository, {required String email})
      : super(VerifyEmailState(email: email));

  Future<void> resendOTP() async {
    emit(state.copyWith(resendOTPStatus: ResendOTPStatus.resending));
    final ResendOTPResponse? _response =
        await _verifyEmailRepository.resendOTP(email: state.email);
    if (_response == null || !_response.status) {
      emit(state.copyWith(resendOTPStatus: ResendOTPStatus.fail));
      return;
    }
    if (_response.status) {
      emit(state.copyWith(resendOTPStatus: ResendOTPStatus.success));
      emit(state.copyWith(resendOTPStatus: ResendOTPStatus.idle));
    }
    if (state.timeout == null) {
      emit(state.copyWith(
        timeout: _timeoutDuration,
      ));
      _timerTick();
    }
  }

  Future<void> validateOTP(String otp) async {
    emit(state.copyWith(
      otp: state.otp.copyWith(
        value: otp,
        error: null,
      ),
      verifyEmailStatus: VerifyEmailStatus.verifying,
    ));
    final VerifyEmailResponse? _response =
        await _verifyEmailRepository.verifyEmail(otp: state.otp.value!);
    if (_response == null) {
      emit(state.copyWith(
        verifyEmailStatus: VerifyEmailStatus.verify,
      ));
    } else {
      if (!_response.status) {
        emit(state.copyWith(
          otp: state.otp
              .copyWith(error: (BuildContext context) => _response.message),
          verifyEmailStatus: VerifyEmailStatus.verify,
        ));
      } else {
        emit(state.copyWith(
          verifyEmailStatus: VerifyEmailStatus.done,
        ));
      }
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
