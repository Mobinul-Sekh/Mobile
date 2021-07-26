part of 'verify_email_bloc.dart';

class VerifyEmailState with EquatableMixin {
  String? email;
  late final BlocFormField<String> otp;
  int? timeout;
  VerifyEmailStatus verifyEmailStatus;

  VerifyEmailState({
    this.email,
    BlocFormField<String>? otp,
    this.timeout,
    this.verifyEmailStatus = VerifyEmailStatus.verify,
  }) {
    this.otp = otp ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [email, otp, timeout, verifyEmailStatus];

  VerifyEmailState copyWith({
    String? email,
    BlocFormField<String>? otp,
    int? timeout,
    VerifyEmailStatus? verifyEmailStatus,
  }) {
    return VerifyEmailState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      timeout: timeout == null ? this.timeout : (timeout <= 0 ? null : timeout),
      verifyEmailStatus: verifyEmailStatus ?? this.verifyEmailStatus,
    );
  }
}

enum VerifyEmailStatus {
  verify,
  verifying,
  done,
}
