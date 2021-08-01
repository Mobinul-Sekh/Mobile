// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/modules/owner_subscription/models/owner_subscription_response.dart';
import 'package:bitecope/modules/owner_subscription/repositories/owner_subscription_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'owner_subscription_state.dart';

class OwnerSubscriptionBloc extends Cubit<OwnerSubscriptionState> {
  final OwnerSubscriptionRepository _ownerSubscriptionRepository;
  OwnerSubscriptionBloc(
    this._ownerSubscriptionRepository, {
    required String username,
  }) : super(OwnerSubscriptionState(username: username));

  Future<void> validateKey({
    required String? activationKey,
  }) async {
    if (activationKey == null || activationKey == "") {
      emit(state.copyWith(
        activationKey: state.activationKey.copyWith(
          error: (BuildContext context) =>
              AppLocalizations.of(context)!.keyEmpty,
        ),
      ));
      return;
    }
    emit(state.copyWith(
      ownerSubscriptionStatus: OwnerSubscriptionStatus.activating,
    ));
    final OwnerSubscriptionResponse? _response =
        await _ownerSubscriptionRepository.activate(
      username: state.username,
      activationKey: activationKey,
    );
    if (_response != null) {
      if (_response.status) {
        emit(state.copyWith(
            ownerSubscriptionStatus: OwnerSubscriptionStatus.done));
      } else {
        emit(state.copyWith(
          activationKey: state.activationKey.copyWith(
            error: (BuildContext context) => _response.message,
          ),
          ownerSubscriptionStatus: OwnerSubscriptionStatus.activate,
        ));
      }
    }
  }
}
