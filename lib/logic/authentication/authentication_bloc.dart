import 'package:bitecope/data/repositories/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
