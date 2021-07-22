class SignInResponseModel {
  late String expiresIn;
  late String token;

  SignInResponseModel({required String expiresIn, required String token}) {
    expiresIn = expiresIn;
    token = token;
  }

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    expiresIn = json['Expires_in'] as String;
    token = json['Token'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Expires_in'] = expiresIn;
    data['Token'] = token;
    return data;
  }
}
