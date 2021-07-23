// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/sign_up/repositories/sign_up_repository.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    setStatus(await SignUpRepository().getToken());
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
