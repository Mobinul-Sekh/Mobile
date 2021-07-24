class SignInResponseModel {
  String? expiresIn;
  String? token;
  String? error;

  SignInResponseModel({
    required this.expiresIn,
    required this.token,
    required this.error,
  });

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    expiresIn = json['Expires_in'] as String;
    token = json['Token'] as String;
    error = json['Error'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Expires_in'] = expiresIn;
    data['Token'] = token;
    data['Error'] = error;
    return data;
  }
}
