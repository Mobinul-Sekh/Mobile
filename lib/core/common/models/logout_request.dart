class LogoutRequest {
  String token;

  LogoutRequest({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }
}
