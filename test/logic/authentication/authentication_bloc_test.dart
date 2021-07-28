// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/repositories/common_repository.dart';

void main() {
  group('Authentication Bloc -> ', () {
    late AuthenticationBloc authenticationBloc;
    setUp(() {
      authenticationBloc = AuthenticationBloc(CommonRepository());
    });
    tearDown(() {
      authenticationBloc.close();
    });
    test('Start |  Status: Loading', () {
      expect(
        authenticationBloc.state,
        AuthenticationState(),
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
