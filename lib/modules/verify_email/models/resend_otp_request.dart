class ResendOTPRequest {
  String username;

  ResendOTPRequest({
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': username,
    };
  }
}
