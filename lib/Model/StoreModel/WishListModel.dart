class WishListModel {
  List<WishListResult> result;
  String message;
  String status;

  WishListModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    result: List<WishListResult>.from(json["result"].map((x) => WishListResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class WishListResult {
  String id;
  String userId;
  String productId;
  String quantity;
  String amount;
  DateTime dateTime;
  String productAmount;
  String productName;
  String description;
  String productImage;

  WishListResult({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.amount,
    required this.dateTime,
    required this.productAmount,
    required this.productName,
    required this.description,
    required this.productImage,
  });

  factory WishListResult.fromJson(Map<String, dynamic> json) => WishListResult(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    amount: json["amount"],
    dateTime: DateTime.parse(json["date_time"]),
    productAmount: json["product_amount"],
    productName: json["product_name"],
    description: json["description"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "quantity": quantity,
    "amount": amount,
    "date_time": dateTime.toIso8601String(),
    "product_amount": productAmount,
    "product_name": productName,
    "description": description,
    "product_image": productImage,
  };
}
