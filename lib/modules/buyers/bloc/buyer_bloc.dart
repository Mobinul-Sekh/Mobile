// Flutter imports:
import 'package:bitecope/modules/buyers/models/add_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/delete_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/edit_buyer_response.dart';
import 'package:bitecope/modules/buyers/repositories/buyer_repository.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';

import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

import 'buyer_list_bloc.dart';

part 'buyer_state.dart';

class BuyerBloc extends Cubit<BuyerState> {
  final BuyerListBloc _buyerListBloc;
  late final BuyerRepository _buyerRepository;

  BuyerBloc(this._buyerListBloc) : super(BuyerState()) {
    _buyerRepository = _buyerListBloc.repository;
  }

  void validateBuyer({
    String? name,
    String? phoneNumber,
    String? address,
    String? description,
  }) {
    final String? _name = name?.trim();
    final String? _phoneNumber = phoneNumber?.trim().replaceAll(' ', '');
    final String? _address = address?.trim();
    //! For description, we should either send null or a non-empty string;
    //!   if we send empty string, API returns error.
    final String? _description =
        description?.trim() == "" ? null : description?.trim();

    final Map<String, LocaleString?> _errors = {
      "name": _validateName(_name),
      "phoneNumber": _validatePhoneNumber(_phoneNumber),
      "address": _validateAddress(_address),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(
      BuyerState(
        name: BlocFormField(_name, _errors['name']),
        phoneNumber: BlocFormField(_phoneNumber, _errors['phoneNumber']),
        address: BlocFormField(_address, _errors['address']),
        description: BlocFormField(_description),
        buyerStatus: _isValid ? BuyerStatus.createValidated : BuyerStatus.ready,
      ),
    );

    if (_isValid) {
      emit(state.copyWith(buyerStatus: BuyerStatus.confirmCreate));
    }
  }

  Future<void> addBuyer() async {
    emit(state.copyWith(buyerStatus: BuyerStatus.loading));

    final AddBuyerResponse? _response = await _buyerRepository.addBuyer(
      name: state.name.value!,
      phoneNumber: state.phoneNumber.value!,
      address: state.address.value!,
      description: state.description.value,
    );

    if (_response != null) {
      if (_response.status) {
        emit(state.copyWith(
          buyerStatus: BuyerStatus.done,
        ));
      } else {
        emit(state.copyWith(
          name: state.name.copyWith(
            error: _response.buyerNameError != null
                ? (BuildContext context) => _response.buyerNameError
                : null,
          ),
          phoneNumber: state.phoneNumber.copyWith(
            error: _response.phoneNumberError != null
                ? (BuildContext context) => _response.phoneNumberError
                : null,
          ),
          address: state.address.copyWith(
            error: _response.addressError != null
                ? (BuildContext context) => _response.addressError
                : null,
          ),
          description: state.description.copyWith(
            error: _response.descriptionError != null
                ? (BuildContext context) => _response.descriptionError
                : null,
          ),
          error: _response.otherError != null
              ? (BuildContext context) => _response.otherError
              : null,
          buyerStatus: BuyerStatus.ready,
        ));
      }
    }
  }

  void confirmEdit({
    required String buyerID,
    String? description,
  }) {
    final String? _description =
        description?.trim() == "" ? null : description?.trim();
    emit(state.copyWith(
      id: buyerID,
      description: BlocFormField(_description),
      buyerStatus: BuyerStatus.editValidated,
    ));
    emit(state.copyWith(
      buyerStatus: BuyerStatus.confirmEdit,
    ));
  }

  Future<void> editBuyer() async {
    emit(state.copyWith(buyerStatus: BuyerStatus.loading));

    final EditBuyerResponse? _response = await _buyerRepository.editBuyer(
      buyerID: state.id!,
      description: state.description.value,
    );

    if (_response != null) {
      if (_response.status) {
        _buyerListBloc.editBuyer(
          buyerID: state.id!,
          description: state.description.value,
        );
        emit(state.copyWith(
          buyerStatus: BuyerStatus.done,
        ));
      } else {
        emit(state.copyWith(
          error: (BuildContext context) => _response.message,
          buyerStatus: BuyerStatus.ready,
        ));
      }
    }
  }

  void confirmDelete({
    required String buyerID,
  }) {
    emit(state.copyWith(
      id: buyerID,
      buyerStatus: BuyerStatus.deleteValidated,
    ));
    emit(state.copyWith(
      buyerStatus: BuyerStatus.confirmDelete,
    ));
  }

  Future<void> deleteBuyer() async {
    emit(state.copyWith(buyerStatus: BuyerStatus.loading));

    final DeleteBuyerResponse? _response = await _buyerRepository.deleteBuyer(
      buyerID: state.id!,
    );

    if (_response != null) {
      if (_response.status) {
        _buyerListBloc.deleteBuyer(
          buyerID: state.id!,
        );
        emit(state.copyWith(
          buyerStatus: BuyerStatus.done,
        ));
      } else {
        emit(state.copyWith(
          error: (BuildContext context) => _response.message,
          buyerStatus: BuyerStatus.ready,
        ));
      }
    }
  }

  LocaleString? _validateName(String? name) {
    if (name == null || name == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.buyerNameEmpty;
    }
    return null;
  }

  LocaleString? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.phoneNumberEmpty;
    }
    final String _phoneNumber = phoneNumber.trim().replaceAll(' ', '');
    if (_phoneNumber.length != 10) {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.phoneNumberInvalid;
    }
    return null;
  }

  LocaleString? _validateAddress(String? address) {
    if (address == null || address == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.buyerAddressEmpty;
    }
    return null;
  }
}
