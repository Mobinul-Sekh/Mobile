part of 'owner_subscription_bloc.dart';

class OwnerSubscriptionState with EquatableMixin {
  String username;
  late final BlocFormField<String> activationKey;
  OwnerSubscriptionStatus ownerSubscriptionStatus;

  OwnerSubscriptionState({
    required this.username,
    BlocFormField<String>? activationKey,
    this.ownerSubscriptionStatus = OwnerSubscriptionStatus.activate,
  }) {
    this.activationKey = activationKey ?? BlocFormField<String>();
  }

  @override
  List<Object> get props => [
        username,
        activationKey,
        ownerSubscriptionStatus,
      ];

  OwnerSubscriptionState copyWith({
    String? username,
    BlocFormField<String>? activationKey,
    OwnerSubscriptionStatus? ownerSubscriptionStatus,
  }) {
    return OwnerSubscriptionState(
      username: username ?? this.username,
      activationKey: activationKey ?? this.activationKey,
      ownerSubscriptionStatus:
          ownerSubscriptionStatus ?? this.ownerSubscriptionStatus,
    );
  }
}

enum OwnerSubscriptionStatus {
  activate,
  activating,
  done,
}
