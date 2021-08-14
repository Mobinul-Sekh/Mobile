// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_state.dart';

class NetworkBloc extends Cubit<NetworkState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  NetworkBloc(this.connectivity) : super(NetworkState()) {
    _init();
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen(_handleConnection);
  }

  Future<void> _init() async {
    _handleConnection(await connectivity.checkConnectivity());
  }

  void _handleConnection(ConnectivityResult connection) {
    if (connection == ConnectivityResult.none) {
      emit(state.copyWith(status: NetworkStatus.disconnected));
    } else {
      if (state.status == NetworkStatus.disconnected) {
        emit(state.copyWith(status: NetworkStatus.reconnected));
      }
      emit(state.copyWith(status: NetworkStatus.connected));
    }
  }

  Future<bool> isConnected() async {
    if (state.status == NetworkStatus.connected) {
      return true;
    }
    return false;
  }

  Future<void> tryConnecting() async {
    _handleConnection(await connectivity.checkConnectivity());
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
