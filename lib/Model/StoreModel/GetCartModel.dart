class GetCartModel {
  List<GetCartResult> result;
  String message;
  String status;
  String? totalAmount;

  GetCartModel({
    required this.result,
    required this.message,
    required this.status,
    this.totalAmount,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
    result: List<GetCartResult>.from(json["result"].map((x) => GetCartResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
    totalAmount:(json["total_amount"]),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
    "total_amount": totalAmount,
  };
}

class GetCartResult {
  String id;
  String categoryId;
  String productName;
  String productPrice;
  String productImage;
  String description;
  String stock;
  DateTime dateTime;
  String productSize;
  String productColor;
  String userId;
  String type;
  String quantity;
  String productId;
  String cartId;

  GetCartResult({
    required this.id,
    required this.categoryId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.description,
    required this.stock,
    required this.dateTime,
    required this.productSize,
    required this.productColor,
    required this.userId,
    required this.type,
    required this.quantity,
    required this.productId,
    required this.cartId,
  });

  factory GetCartResult.fromJson(Map<String, dynamic> json) => GetCartResult(
    id: json["id"],
    categoryId: json["category_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
    description: json["description"],
    stock: json["stock"],
    dateTime: DateTime.parse(json["date_time"]),
    productSize: json["product_size"],
    productColor: json["product_color"],
    userId: json["user_id"],
    type: json["type"],
    quantity: json["quantity"],
    productId: json["product_id"],
    cartId: json["cart_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
    "description": description,
    "stock": stock,
    "date_time": dateTime.toIso8601String(),
    "product_size": productSize,
    "product_color": productColor,
    "user_id": userId,
    "type": type,
    "quantity": quantity,
    "product_id": productId,
    "cart_id": cartId,
  };
}
