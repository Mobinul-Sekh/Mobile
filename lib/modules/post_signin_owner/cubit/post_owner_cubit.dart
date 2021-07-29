import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/modules/post_signin_owner/model/post_owner_response_model.dart';
import 'package:bitecope/modules/post_signin_owner/repositories/post_owner_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'post_owner_state.dart';

class PostOwnerCubit extends Cubit<PostOwnerState> {
  PostOwnerRepository postOwnerRepository;
  PostOwnerCubit({required this.postOwnerRepository}) : super(PostOwnerState());

  void validatePostOwnerPage({
    String? ownerName,
    String? email,
    String? phoneNumber,
    String? companyName,
    String? companyAddress,
  }) {
    final Map<String, LocaleString?> _errors = {
      "ownerName": _validateOwnerName(ownerName),
      "email": _validateEmail(email),
      "phoneNumber": _validatePhoneNumber(phoneNumber),
      "companyName": _validateCompanyName(companyName),
      "companyAddress": _validateCompanyAddress(companyAddress),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(
      state.copyWith(
        ownerName: BlocFormField(
          ownerName,
          _errors["ownerName"],
        ),
        email: BlocFormField(
          email,
          _errors["email"],
        ),
        phoneNumber: BlocFormField(
          phoneNumber,
          _errors["phoneNumber"],
        ),
        companyName: BlocFormField(
          companyName,
          _errors["companyName"],
        ),
        companyAddress: BlocFormField(
          companyAddress,
          _errors["companyAddress"],
        ),
        postOwnerStatus: _isValid
            ? PostOwnerStatus.ownerInserting
            : PostOwnerStatus.ownerInsert,
      ),
    );

    if (_isValid) {
      insertOwnerDetails();
    }
  }

  Future<void> insertOwnerDetails() async {
    final PostOwnerResponseModel? response =
        await postOwnerRepository.insertOwnerDetails(
      ownerName: state.ownerName.value!,
      companyAddress: state.companyAddress.value,
      companyName: state.companyName.value!,
      email: state.email.value!,
      phoneNumber: state.phoneNumber.value!,
    );
    if (response != null) {
      // TODO We'll set the token when we have logout ready
      // signInRepository.setToken(response.token!);
      emit(state.copyWith(postOwnerStatus: PostOwnerStatus.ownerInserted));
    } else {
      _setErrors(response!);
    }
  }

  LocaleString? _validateOwnerName(String? ownerName) {
    if (ownerName == null || ownerName.trim() == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.usernameEmpty;
    }
    return null;
  }

  LocaleString? _validateEmail(String? email) {
    if (email == null || email == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.passwordEmpty;
    }
    return null;
  }

  LocaleString? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.passwordEmpty;
    }
    return null;
  }

  LocaleString? _validateCompanyName(String? companyName) {
    if (companyName == null || companyName == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.passwordEmpty;
    }
    return null;
  }

  LocaleString? _validateCompanyAddress(String? companyAddress) {
    if (companyAddress == null || companyAddress == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.passwordEmpty;
    }
    return null;
  }

  void _setErrors(PostOwnerResponseModel response) {
    //TODO Need a list of possible API errors for each field to localize them; for now returning the errors as they are.
    emit(
      state.copyWith(
        email: state.email.copyWith(
          error: response.email != null
              ? (BuildContext context) => response.email
              : null,
        ),
        phoneNumber: state.phoneNumber.copyWith(
          error: response.phoneNo != null
              ? (BuildContext context) => response.phoneNo
              : null,
        ),
        companyName: state.companyName.copyWith(
          error: response.companyDetails != null
              ? (BuildContext context) => response.companyDetails
              : null,
        ),
        postOwnerStatus: PostOwnerStatus.ownerInsert,
      ),
    );
  }
}
