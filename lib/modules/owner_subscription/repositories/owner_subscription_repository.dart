// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/owner_subscription/models/owner_subscription_request.dart';
import 'package:bitecope/modules/owner_subscription/models/owner_subscription_response.dart';
import 'package:bitecope/modules/owner_subscription/providers/owner_subscription_provider.dart';

class OwnerSubscriptionRepository extends CommonRepository {
  final OwnerSubscriptionProvider _ownerSubscriptionProvider =
      OwnerSubscriptionProvider();

  Future<OwnerSubscriptionResponse?> activate({
    required String username,
    required String activationKey,
  }) async {
    final OwnerSubscriptionRequest request = OwnerSubscriptionRequest(
      username: username,
      activationKey: activationKey,
    );
    final Map<String, dynamic>? responseMap =
        await _ownerSubscriptionProvider.activate(request);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final OwnerSubscriptionResponse response =
        OwnerSubscriptionResponse.fromMap(responseMap);
    return response;
  }
}
