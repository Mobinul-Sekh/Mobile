part of 'buyer_bloc.dart';

class BuyerState with EquatableMixin {
  late final String? id;
  late final BlocFormField<String> name;
  late final BlocFormField<String> phoneNumber;
  late final BlocFormField<String> address;
  late final BlocFormField<String> description;
  LocaleString? error;
  BuyerStatus buyerStatus;

  BuyerState({
    this.id,
    BlocFormField<String>? name,
    BlocFormField<String>? phoneNumber,
    BlocFormField<String>? address,
    BlocFormField<String>? description,
    this.error,
    this.buyerStatus = BuyerStatus.ready,
  }) {
    this.name = name ?? BlocFormField<String>();
    this.phoneNumber = phoneNumber ?? BlocFormField<String>();
    this.address = address ?? BlocFormField<String>();
    this.description = description ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        address,
        description,
        error,
        buyerStatus,
      ];

  BuyerState copyWith({
    String? id,
    BlocFormField<String>? name,
    BlocFormField<String>? phoneNumber,
    BlocFormField<String>? address,
    BlocFormField<String>? description,
    LocaleString? error,
    BuyerStatus? buyerStatus,
  }) {
    return BuyerState(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      description: description ?? this.description,
      error: error ?? this.error,
      buyerStatus: buyerStatus ?? this.buyerStatus,
    );
  }
}

enum BuyerStatus {
  ready,
  createValidated,
  editValidated,
  deleteValidated,
  confirmCreate,
  confirmEdit,
  confirmDelete,
  loading,
  done,
}
