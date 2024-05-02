class ProductDetailsModel {
  ProductDetailsResult result;
  String message;
  String status;

  ProductDetailsModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    result: ProductDetailsResult.fromJson(json["result"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "message": message,
    "status": status,
  };
}

class ProductDetailsResult {
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
  String wishListStatus;
  dynamic categoryName;

  ProductDetailsResult({
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
    required this.wishListStatus,
    required this.categoryName,
  });

  factory ProductDetailsResult.fromJson(Map<String, dynamic> json) => ProductDetailsResult(
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
    wishListStatus: json["wish_list_status"],
    categoryName: json["category_name"],
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
    "wish_list_status": wishListStatus,
    "category_name": categoryName,
  };
}
