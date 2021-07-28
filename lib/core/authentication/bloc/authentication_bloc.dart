// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';

// Project imports:

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  final CommonRepository _commonRepository;

  AuthenticationBloc(this._commonRepository) : super(AuthenticationState()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    setStatus(await _commonRepository.getToken());
  }

  void setStatus([String? token]) {
    if (token != null) {
      emit(
        AuthenticationState(
          status: AuthenticationStatus.loggedIn,
          token: token,
        ),
      );
    } else {
      emit(
        AuthenticationState(
          status: AuthenticationStatus.loggedOut,
        ),
      );
    }
  }
}
