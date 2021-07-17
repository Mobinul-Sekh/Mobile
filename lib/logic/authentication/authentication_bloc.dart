import 'package:bitecope/data/account_repository.dart';
import 'package:bloc/bloc.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    final token = await AccountRepository().getToken();
    if (token != null) {
      emit(AuthenticationState(status: AuthenticationStatus.loggedIn));
    } else {
      emit(AuthenticationState(status: AuthenticationStatus.loggedOut));
    }
  }
}
