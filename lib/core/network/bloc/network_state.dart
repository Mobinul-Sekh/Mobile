part of 'network_bloc.dart';

class NetworkState with EquatableMixin {
  NetworkStatus status;

  NetworkState({this.status = NetworkStatus.loading});

  @override
  List<Object?> get props => [status];

  NetworkState copyWith({
    NetworkStatus? status,
  }) {
    return NetworkState(
      status: status ?? this.status,
    );
  }
}

enum NetworkStatus {
  loading,
  connected,
  disconnected,
  reconnected,
}
