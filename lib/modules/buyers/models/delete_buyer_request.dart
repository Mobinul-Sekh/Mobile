class DeleteBuyerRequest {
  String buyerID;

  DeleteBuyerRequest({
    required this.buyerID,
  });

  Map<String, dynamic> toMap() {
    return {
      'buyer_id': buyerID,
    };
  }
}
