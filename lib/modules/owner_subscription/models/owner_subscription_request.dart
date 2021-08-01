class OwnerSubscriptionRequest {
  String username;
  String activationKey;

  OwnerSubscriptionRequest({
    required this.username,
    required this.activationKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': username,
      'activation_key': activationKey,
    };
  }
}
