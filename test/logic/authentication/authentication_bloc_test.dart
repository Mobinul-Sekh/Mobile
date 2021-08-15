// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/core/network/bloc/network_bloc.dart';

void main() {
  group('Authentication Bloc -> ', () {
    late AuthenticationBloc authenticationBloc;
    setUp(() {
      authenticationBloc = AuthenticationBloc(
        CommonRepository(),
        NetworkBloc(Connectivity()),
      );
    });
    tearDown(() {
      authenticationBloc.close();
    });
    test('Start | Status: Loading', () {
      expect(
        authenticationBloc.state,
        AuthenticationState(),
      );
    });
  });
}
