// Dart imports:
import 'dart:convert';

class PostOwnerResponseModel {
  String? status;
  String? email;
  String? phoneNo;
  String? companyDetails;

  PostOwnerResponseModel({
    this.status,
    this.email,
    this.phoneNo,
    this.companyDetails,
  });

  factory PostOwnerResponseModel.fromMap(Map<String, dynamic> map) {
    return PostOwnerResponseModel(
      status: map['status'] != null ? map['status'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNo: map['phone_no'] != null ? map['phone_no'] as String : null,
      companyDetails: map['company_details'] != null
          ? map['company_details'] as String
          : null,
    );
  }

  factory PostOwnerResponseModel.fromJson(String source) =>
      PostOwnerResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
