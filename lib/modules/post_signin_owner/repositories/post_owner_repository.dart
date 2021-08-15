// Package imports:
import 'package:bitecope/modules/post_signin_owner/model/post_owner_request_model.dart';
import 'package:bitecope/modules/post_signin_owner/model/post_owner_response_model.dart';
import 'package:bitecope/modules/post_signin_owner/providers/post_owner_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:

class PostOwnerRepository {
  final PostOwnerProvider postOwnerProvider = PostOwnerProvider();

  Future<PostOwnerResponseModel?> insertOwnerDetails({
    required String ownerName,
    required String email,
    required String phoneNumber,
    required String companyName,
    required String? companyAddress,
  }) async {
    final PostOwnerRequestModel postOwnerRequestModel = PostOwnerRequestModel(
      companyName: companyName,
      email: email,
      ownerName: ownerName,
      phoneNumber: phoneNumber,
      companyAddress: companyAddress,
    );
    final Map<String, dynamic>? responseMap =
        await postOwnerProvider.insertOwnerDetailsApi(
      request: postOwnerRequestModel,
      token: await getToken(),
    );

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final PostOwnerResponseModel response =
        PostOwnerResponseModel.fromMap(responseMap);
    return response;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
