class GetProductByCategoryModel {
  List<GetProductByCategoryResult> result;
  String message;
  String status;

  GetProductByCategoryModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory GetProductByCategoryModel.fromJson(Map<String, dynamic> json) => GetProductByCategoryModel(
    result: List<GetProductByCategoryResult>.from(json["result"].map((x) => GetProductByCategoryResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetProductByCategoryResult {
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
  String categoryName;

  GetProductByCategoryResult({
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

  factory GetProductByCategoryResult.fromJson(Map<String, dynamic> json) => GetProductByCategoryResult(
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
