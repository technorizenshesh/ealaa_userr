class CategoryModel {
  List<CategoryResult> result;
  String message;
  String status;

  CategoryModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    result: List<CategoryResult>.from(json["result"].map((x) => CategoryResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class CategoryResult {
  String id;
  String categoryName;
  String image;
  DateTime dateTime;

  CategoryResult({
    required this.id,
    required this.categoryName,
    required this.image,
    required this.dateTime,
  });

  factory CategoryResult.fromJson(Map<String, dynamic> json) => CategoryResult(
    id: json["id"],
    categoryName: json["category_name"],
    image: json["image"],
    dateTime: DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "image": image,
    "date_time": dateTime.toIso8601String(),
  };
}
