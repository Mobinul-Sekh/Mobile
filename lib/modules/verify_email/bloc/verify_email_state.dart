part of 'verify_email_bloc.dart';

class VerifyEmailState with EquatableMixin {
  String email;
  late final BlocFormField<String> otp;
  int? timeout;
  VerifyEmailStatus verifyEmailStatus;
  ResendOTPStatus resendOTPStatus;

  VerifyEmailState({
    required this.email,
    BlocFormField<String>? otp,
    this.timeout,
    this.verifyEmailStatus = VerifyEmailStatus.verify,
    this.resendOTPStatus = ResendOTPStatus.idle,
  }) {
    this.otp = otp ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        email,
        otp,
        timeout,
        verifyEmailStatus,
        resendOTPStatus,
      ];

  VerifyEmailState copyWith({
    String? email,
    BlocFormField<String>? otp,
    int? timeout,
    VerifyEmailStatus? verifyEmailStatus,
    ResendOTPStatus? resendOTPStatus,
  }) {
    return VerifyEmailState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      timeout: timeout == null ? this.timeout : (timeout <= 0 ? null : timeout),
      verifyEmailStatus: verifyEmailStatus ?? this.verifyEmailStatus,
      resendOTPStatus: resendOTPStatus ?? this.resendOTPStatus,
    );
  }
}

enum VerifyEmailStatus {
  verify,
  verifying,
  done,
}

enum ResendOTPStatus {
  idle,
  resending,
  success,
  fail,
}
