// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/buyers/models/add_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/add_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/delete_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/delete_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/edit_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/edit_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/get_buyer_response.dart';
import 'package:bitecope/modules/buyers/providers/buyer_provider.dart';

class BuyerRepository extends CommonRepository {
  final BuyerProvider _buyerProvider = BuyerProvider();

  Future<GetBuyersResponse?> getBuyers() async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final Map<String, dynamic>? _responseMap =
        await _buyerProvider.getBuyers(_authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final GetBuyersResponse _response = GetBuyersResponse.fromMap(_responseMap);
    return _response;
  }

  Future<AddBuyerResponse?> addBuyer({
    required String name,
    required String phoneNumber,
    required String address,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final AddBuyerRequest request = AddBuyerRequest(
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      description: description,
    );
    print(request.name);
    final Map<String, dynamic>? _responseMap =
        await _buyerProvider.addBuyer(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final AddBuyerResponse _response = AddBuyerResponse.fromMap(_responseMap);
    return _response;
  }

  Future<EditBuyerResponse?> editBuyer({
    required String buyerID,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final EditBuyerRequest request = EditBuyerRequest(
      buyerID: buyerID,
      description: description,
    );
    final Map<String, dynamic>? _responseMap =
        await _buyerProvider.editBuyer(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final EditBuyerResponse _response = EditBuyerResponse.fromMap(_responseMap);
    return _response;
  }

  Future<DeleteBuyerResponse?> deleteBuyer({
    required String buyerID,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final DeleteBuyerRequest request = DeleteBuyerRequest(
      buyerID: buyerID,
    );
    final Map<String, dynamic>? _responseMap =
        await _buyerProvider.deleteBuyer(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final DeleteBuyerResponse _response =
        DeleteBuyerResponse.fromMap(_responseMap);
    return _response;
  }
}
