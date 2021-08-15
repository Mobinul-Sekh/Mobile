part of 'post_owner_cubit.dart';

class PostOwnerState {
  late final BlocFormField<String> ownerName;
  late final BlocFormField<String> email;
  late final BlocFormField<String> phoneNumber;
  late final BlocFormField<String> companyName;
  late final BlocFormField<String> companyAddress;
  late PostOwnerStatus postOwnerStatus;
  PostOwnerState(
      {BlocFormField<String>? ownerName,
      BlocFormField<String>? email,
      BlocFormField<String>? phoneNumber,
      BlocFormField<String>? companyName,
      BlocFormField<String>? companyAddress,
      this.postOwnerStatus = PostOwnerStatus.ownerInsert}) {
    this.ownerName = ownerName ?? BlocFormField();
    this.email = email ?? BlocFormField();
    this.phoneNumber = phoneNumber ?? BlocFormField();
    this.companyName = companyName ?? BlocFormField();
    this.companyAddress = companyAddress ?? BlocFormField();
  }

  PostOwnerState copyWith({
    BlocFormField<String>? ownerName,
    BlocFormField<String>? email,
    BlocFormField<String>? phoneNumber,
    BlocFormField<String>? companyName,
    BlocFormField<String>? companyAddress,
    PostOwnerStatus? postOwnerStatus,
  }) {
    return PostOwnerState(
      ownerName: ownerName ?? this.ownerName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      postOwnerStatus: postOwnerStatus ?? this.postOwnerStatus,
    );
  }
}

enum PostOwnerStatus {
  ownerInsert,
  ownerInserting,
  ownerInserted,
}
