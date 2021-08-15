part of 'buyer_list_bloc.dart';

class BuyerListState with EquatableMixin {
  List<Buyer>? buyers;
  BuyerListStatus buyerListStatus;

  BuyerListState({
    this.buyers,
    this.buyerListStatus = BuyerListStatus.loading,
  });

  @override
  List<Object?> get props => [buyers, buyerListStatus];

  BuyerListState copyWith({
    List<Buyer>? buyers,
    BuyerListStatus? buyerListStatus,
  }) {
    return BuyerListState(
      buyers: buyers ?? this.buyers,
      buyerListStatus: buyerListStatus ?? this.buyerListStatus,
    );
  }
}

enum BuyerListStatus {
  loading,
  ready,
  failed,
}
