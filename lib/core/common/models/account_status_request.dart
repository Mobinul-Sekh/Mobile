class AccountStatusRequest {
  String username;

  AccountStatusRequest({required this.username});

  Map<String, dynamic> toMap() {
    return {
      'user_name': username,
    };
  }
}
