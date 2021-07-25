// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/splash_screen/repositories/account_repository.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    setStatus(await AccountRepository().getToken());
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
