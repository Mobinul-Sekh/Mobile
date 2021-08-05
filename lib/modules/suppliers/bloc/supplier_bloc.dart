// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/modules/suppliers/models/add_supplier_response.dart';
import 'package:bitecope/modules/suppliers/models/edit_supplier_response.dart';
import 'package:bitecope/modules/suppliers/repositories/supplier_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'supplier_state.dart';

class SupplierBloc extends Cubit<SupplierState> {
  final SupplierRepository _supplierRepository;

  SupplierBloc(this._supplierRepository) : super(SupplierState());

  void validateSupplier({
    String? name,
    String? phoneNumber,
    String? address,
    String? description,
  }) {
    final String? _name = name?.trim();
    final String? _phoneNumber = phoneNumber?.trim();
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
      SupplierState(
        name: BlocFormField(_name, _errors['name']),
        phoneNumber: BlocFormField(_phoneNumber, _errors['phoneNumber']),
        address: BlocFormField(_address, _errors['address']),
        description: BlocFormField(_description),
        supplierStatus:
            _isValid ? SupplierStatus.createValidated : SupplierStatus.ready,
      ),
    );

    if (_isValid) {
      emit(state.copyWith(supplierStatus: SupplierStatus.confirmCreate));
    }
  }

  Future<void> addSupplier() async {
    emit(state.copyWith(supplierStatus: SupplierStatus.loading));

    final AddSupplierResponse? _response =
        await _supplierRepository.addSupplier(
      name: state.name.value!,
      phoneNumber: state.phoneNumber.value!,
      address: state.address.value!,
      description: state.description.value,
    );

    if (_response != null) {
      if (_response.status) {
        emit(state.copyWith(
          supplierStatus: SupplierStatus.done,
        ));
      } else {
        emit(state.copyWith(
          name: state.name.copyWith(
            error: _response.supplierNameError != null
                ? (BuildContext context) => _response.supplierNameError
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
          supplierStatus: SupplierStatus.ready,
        ));
      }
    }
  }

  void confirmEdit({
    required String supplierID,
    String? description,
  }) {
    final String? _description =
        description?.trim() == "" ? null : description?.trim();
    emit(state.copyWith(
      id: supplierID,
      description: BlocFormField(_description),
      supplierStatus: SupplierStatus.editValidated,
    ));
    emit(state.copyWith(
      supplierStatus: SupplierStatus.confirmEdit,
    ));
  }

  Future<void> editSupplier() async {
    emit(state.copyWith(supplierStatus: SupplierStatus.loading));

    final EditSupplierResponse? _response =
        await _supplierRepository.editSupplier(
      supplierID: state.id!,
      description: state.description.value,
    );

    if (_response != null) {
      if (_response.status) {
        emit(state.copyWith(
          supplierStatus: SupplierStatus.done,
        ));
      } else {
        emit(state.copyWith(
          error: (BuildContext context) => _response.message,
          supplierStatus: SupplierStatus.ready,
        ));
      }
    }
  }

  LocaleString? _validateName(String? name) {
    if (name == null || name == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.supplierNameEmpty;
    }
    return null;
  }

  LocaleString? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.phoneNumberEmpty;
    }
    return null;
  }

  LocaleString? _validateAddress(String? address) {
    if (address == null || address == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.supplierAddressEmpty;
    }
    return null;
  }
}
