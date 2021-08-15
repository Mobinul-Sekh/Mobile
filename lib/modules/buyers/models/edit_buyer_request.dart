class EditBuyerRequest {
  String buyerID;
  String? description;

  EditBuyerRequest({
    required this.buyerID,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'buyer_id': buyerID,
      'description': description,
    };
  }
}
