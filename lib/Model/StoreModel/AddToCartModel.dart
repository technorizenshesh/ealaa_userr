class AddToCartModel {
  AddToCartResult result;
  String message;
  String status;

  AddToCartModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
    result: AddToCartResult.fromJson(json["result"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "message": message,
    "status": status,
  };
}

class AddToCartResult {
  String id;
  String userId;
  String productId;
  String storeId;
  String quantity;
  String amount;
  DateTime dateTime;

  AddToCartResult({
    required this.id,
    required this.userId,
    required this.productId,
    required this.storeId,
    required this.quantity,
    required this.amount,
    required this.dateTime,
  });

  factory AddToCartResult.fromJson(Map<String, dynamic> json) => AddToCartResult(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    storeId: json["store_id"]??"",
    quantity: json["quantity"],
    amount: json["amount"],
    dateTime: DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "store_id": storeId,
    "quantity": quantity,
    "amount": amount,
    "date_time": dateTime.toIso8601String(),
  };
}
