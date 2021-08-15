// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Project imports:
import 'package:bitecope/core/common/models/account_status_response.dart';
import 'package:bitecope/core/common/models/logout_response.dart';
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/core/network/bloc/network_bloc.dart';

// Project imports:

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  final CommonRepository _commonRepository;
  final NetworkBloc _networkBloc;
  late StreamSubscription _networkStreamSubscription;

  AuthenticationBloc(
    this._commonRepository,
    this._networkBloc,
  ) : super(AuthenticationState()) {
    setStatus();
    _networkStreamSubscription = _networkBloc.stream.listen((state) {
      if (state.status == NetworkStatus.reconnected) {
        setStatus();
      }
    });
  }

  Future<void> setStatus([_AuthenticationData? _authenticationData]) async {
    _AuthenticationData? _authData;
    if (_authenticationData == null) {
      final String? _username = await _commonRepository.getUsername();
      final UserType? _userType =
          parseUserType[await _commonRepository.getUserType()];
      final String? _token = await _commonRepository.getToken();
      final DateTime? _expiry =
          DateTime.tryParse(await _commonRepository.getExpiry() ?? "");
      if (_username != null &&
          _userType != null &&
          _token != null &&
          _expiry != null) {
        _authData = _AuthenticationData(
          username: _username,
          userType: _userType,
          token: _token,
          expiry: _expiry,
        );
      }
    } else {
      _authData = _authenticationData;
      await _commonRepository.setToken(_authData.token);
      await _commonRepository.setUsername(_authData.username);
      await _commonRepository.setUserType(_authData.userType.id.toString());
      await _commonRepository.setExpiry(_authData.expiry.toString());
    }
    if (_authData == null) {
      emit(
        AuthenticationState(
          status: AuthenticationStatus.loggedOut,
        ),
      );
    } else {
      emit(
        state.copyWith(
          authData: _authData,
          status: AuthenticationStatus.loading,
        ),
      );
      final AccountStatusResponse? response =
          await _commonRepository.accountStatus(username: _authData.username);
      if (response == null || !response.status) {
        return;
      } else {
        if (response.userType == 0) {
          if (!response.activeStatus!) {
            emit(state.copyWith(status: AuthenticationStatus.ownerActivate));
            return;
          }
          if (response.ownerStatus == null) {
            emit(state.copyWith(status: AuthenticationStatus.ownerInitialize));
            return;
          }
        } else if (response.userType == 1) {
          if (response.workerStatus == null) {
            emit(state.copyWith(status: AuthenticationStatus.workerInitialize));
            return;
          }
          if (!response.activeStatus!) {
            emit(state.copyWith(status: AuthenticationStatus.ownerInactive));
            return;
          }
        }
        emit(state.copyWith(status: AuthenticationStatus.loggedIn));
      }
    }
  }

  void signedIn(
      String username, UserType userType, String token, String expiresIn) {
    final int _duration = double.parse(expiresIn).toInt();
    final DateTime _expiry = DateTime.now().add(Duration(seconds: _duration));
    final _AuthenticationData _authenticationData = _AuthenticationData(
      username: username,
      userType: userType,
      token: token,
      expiry: _expiry,
    );
    setStatus(_authenticationData);
    deviceDetails();
  }

  Future<bool?> logout() async {
    emit(state.copyWith(status: AuthenticationStatus.loading));
    final LogoutResponse? response = await _commonRepository.logout();
    if (response != null) {
      if (response.status) {
        emit(AuthenticationState(status: AuthenticationStatus.loggedOut));
      } else {
        emit(state.copyWith(status: AuthenticationStatus.loggedIn));
      }
      return response.status;
    }
  }

  Future<void> deviceDetails() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
      _commonRepository.deviceDetails(
        board: build.board,
        brand: build.brand,
        device: build.device,
        hardware: build.hardware,
        host: build.host,
        deviceID: build.id,
        manufacturer: build.manufacturer,
        deviceModel: build.model,
        product: build.product,
        type: build.type,
        isPhysicalDevice: build.isPhysicalDevice.toString(),
        androidID: build.androidId,
      );
    }
  }

  @override
  Future<void> close() {
    _networkStreamSubscription.cancel();
    return super.close();
  }
}

class _AuthenticationData {
  String username;
  UserType userType;
  String token;
  DateTime expiry;

  _AuthenticationData({
    required this.username,
    required this.userType,
    required this.token,
    required this.expiry,
  });
}
