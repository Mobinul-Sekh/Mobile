import 'package:flutter_test/flutter_test.dart';
import 'package:bitecope/logic/authentication/authentication_bloc.dart';

void main() {
  group('Authentication Bloc -> ', () {
    late AuthenticationBloc authenticationBloc;
    setUp(() {
      authenticationBloc = AuthenticationBloc();
    });
    tearDown(() {
      authenticationBloc.close();
    });
    test('Start |  Status: Loading', () {
      expect(
        authenticationBloc.state,
        AuthenticationState(status: AuthenticationStatus.loading),
      );
    });
    test('Null Token | Status: Logged Out', () {
      authenticationBloc.setStatus();
      expect(
        authenticationBloc.state,
        AuthenticationState(status: AuthenticationStatus.loggedOut),
      );
    });
    test('Valid Token | Status: Logged In', () {
      authenticationBloc.setStatus('dummyToken');
      expect(
        authenticationBloc.state,
        AuthenticationState(
          status: AuthenticationStatus.loggedIn,
          token: 'dummyToken',
        ),
      );
    });
  });
}
