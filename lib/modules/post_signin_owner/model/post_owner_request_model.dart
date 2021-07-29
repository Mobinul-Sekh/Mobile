class PostOwnerRequestModel {
  String ownerName;
  String email;
  String phoneNumber;
  String companyName;
  String? companyAddress;

  PostOwnerRequestModel({
    required this.ownerName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    this.companyAddress,
  });

  Map<String, dynamic> toDatabaseJson() => {
        "owner_name": ownerName,
        "email": email,
        "phone_no": phoneNumber,
        "company_details": companyName,
        "address": companyAddress,
      };
}
