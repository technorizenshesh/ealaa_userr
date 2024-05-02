class BannerModel {
  List<BannerResult> result;
  String message;
  String status;

  BannerModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    result: List<BannerResult>.from(json["result"].map((x) => BannerResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class BannerResult {
  String id;
  String image;
  DateTime dateTime;

  BannerResult({
    required this.id,
    required this.image,
    required this.dateTime,
  });

  factory BannerResult.fromJson(Map<String, dynamic> json) => BannerResult(
    id: json["id"],
    image: json["image"],
    dateTime: DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "date_time": dateTime.toIso8601String(),
  };
}
