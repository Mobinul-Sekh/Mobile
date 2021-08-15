// Package imports:
import 'package:bitecope/modules/buyers/models/buyer.dart';
import 'package:bitecope/modules/buyers/models/get_buyer_response.dart';
import 'package:bitecope/modules/buyers/repositories/buyer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:

part 'buyer_list_state.dart';

class BuyerListBloc extends Cubit<BuyerListState> {
  final BuyerRepository _buyerRepository;

  BuyerRepository get repository => _buyerRepository;

  BuyerListBloc(this._buyerRepository) : super(BuyerListState()) {
    _init();
  }

  Future<void> _init() async {
    final GetBuyersResponse? _response = await _buyerRepository.getBuyers();
    if (_response == null || !_response.status) {
      emit(state.copyWith(
        buyerListStatus: BuyerListStatus.failed,
      ));
      return;
    }
    emit(state.copyWith(
      buyers: _response.buyers,
      buyerListStatus: BuyerListStatus.ready,
    ));
  }

  void editBuyer({
    required String buyerID,
    String? description,
  }) {
    emit(state.copyWith(buyerListStatus: BuyerListStatus.loading));
    final int? _buyerIndex =
        state.buyers?.indexWhere((_buyer) => _buyer.id == buyerID);
    if (_buyerIndex != null) {
      final List<Buyer> _updatedBuyers = state.buyers!;
      _updatedBuyers[_buyerIndex].description = description;
      emit(state.copyWith(
        buyers: _updatedBuyers,
      ));
    }
    emit(state.copyWith(buyerListStatus: BuyerListStatus.ready));
  }

  void deleteBuyer({
    required String buyerID,
  }) {
    emit(state.copyWith(buyerListStatus: BuyerListStatus.loading));
    final int? _buyerIndex =
        state.buyers?.indexWhere((_buyer) => _buyer.id == buyerID);
    if (_buyerIndex != null) {
      final List<Buyer> _updatedBuyers = state.buyers!;
      _updatedBuyers.removeAt(_buyerIndex);
      emit(state.copyWith(
        buyers: _updatedBuyers,
      ));
    }
    emit(state.copyWith(buyerListStatus: BuyerListStatus.ready));
  }
}
