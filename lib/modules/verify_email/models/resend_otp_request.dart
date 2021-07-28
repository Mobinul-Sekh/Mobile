class ResendOTPRequest {
  String email;

  ResendOTPRequest({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email_id': email,
    };
  }
}
