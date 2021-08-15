// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/core/common/models/account_status_response.dart';
import 'package:bitecope/modules/verify_email/models/resend_otp_response.dart';
import 'package:bitecope/modules/verify_email/models/verify_email_response.dart';
import 'package:bitecope/modules/verify_email/repositories/verify_email_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'verify_email_state.dart';

class VerifyEmailBloc extends Cubit<VerifyEmailState> {
  final VerifyEmailRepository _verifyEmailRepository;
  final int _timeoutDuration = 30;
  bool _isRunning = false;

  VerifyEmailBloc(this._verifyEmailRepository, {required String username})
      : super(VerifyEmailState(username: username));

  Future<void> resendOTP() async {
    emit(state.copyWith(resendOTPStatus: ResendOTPStatus.resending));
    final ResendOTPResponse? _response =
        await _verifyEmailRepository.resendOTP(username: state.username);
    if (_response == null || !_response.status) {
      emit(state.copyWith(resendOTPStatus: ResendOTPStatus.fail));
      emit(state.copyWith(resendOTPStatus: ResendOTPStatus.idle));
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
      _resendTimerTick();
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

  Future<void> checkStatus({required bool run}) async {
    if (run && !_isRunning) {
      _isRunning = true;
      await _runStatusCheck();
    } else if (!run && _isRunning) {
      _isRunning = false;
    }
  }

  Future<void> _runStatusCheck() async {
    AccountStatusResponse? _response;
    while (_isRunning) {
      _response =
          await _verifyEmailRepository.accountStatus(username: state.username);
      if (_response == null || !_response.status) {
        return;
      }
      if (_response.mailStatus!) {
        emit(state.copyWith(verifyEmailStatus: VerifyEmailStatus.done));
        return;
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  void _resendTimerTick() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(
          state.copyWith(timeout: state.timeout! - 1),
        );
        if (state.timeout != null) {
          _resendTimerTick();
        }
      },
    );
  }
}
