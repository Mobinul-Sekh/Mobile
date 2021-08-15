part of 'verify_email_bloc.dart';

class VerifyEmailState with EquatableMixin {
  String username;
  late final BlocFormField<String> otp;
  int? timeout;
  VerifyEmailStatus verifyEmailStatus;
  ResendOTPStatus resendOTPStatus;

  VerifyEmailState({
    required this.username,
    BlocFormField<String>? otp,
    this.timeout,
    this.verifyEmailStatus = VerifyEmailStatus.verify,
    this.resendOTPStatus = ResendOTPStatus.idle,
  }) {
    this.otp = otp ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        username,
        otp,
        timeout,
        verifyEmailStatus,
        resendOTPStatus,
      ];

  VerifyEmailState copyWith({
    String? username,
    BlocFormField<String>? otp,
    int? timeout,
    VerifyEmailStatus? verifyEmailStatus,
    ResendOTPStatus? resendOTPStatus,
  }) {
    return VerifyEmailState(
      username: username ?? this.username,
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
