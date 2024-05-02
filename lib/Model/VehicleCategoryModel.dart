class VehicleCategoryModel {
  List<VehicleCategoryResult> result;
  String status;
  String message;

  VehicleCategoryModel({
    required this.result,
    required this.status,
    required this.message,
  });

  factory VehicleCategoryModel.fromJson(Map<String, dynamic> json) => VehicleCategoryModel(
    result: List<VehicleCategoryResult>.from(json["result"].map((x) => VehicleCategoryResult.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class VehicleCategoryResult {
  String vehiclesCategoryId;
  String vehiclesCategoryName;
  String amount;
  String image;
  String distance;
  String miles;
  int perMin;
  int total;
  int cabFind;
  String driverId;

  VehicleCategoryResult({
    required this.vehiclesCategoryId,
    required this.vehiclesCategoryName,
    required this.amount,
    required this.image,
    required this.distance,
    required this.miles,
    required this.perMin,
    required this.total,
    required this.cabFind,
    required this.driverId,
  });

  factory VehicleCategoryResult.fromJson(Map<String, dynamic> json) => VehicleCategoryResult(
    vehiclesCategoryId: json["vehicles_category_id"],
    vehiclesCategoryName: json["vehicles_category_name"],
    amount: json["amount"],
    image: json["image"],
    distance: json["distance"],
    miles: json["miles"],
    perMin: json["perMin"],
    total: json["total"],
    cabFind: json["cab_find"],
    driverId: json["driver_id"],
  );

  Map<String, dynamic> toJson() => {
    "vehicles_category_id": vehiclesCategoryId,
    "vehicles_category_name": vehiclesCategoryName,
    "amount": amount,
    "image": image,
    "distance": distance,
    "miles": miles,
    "perMin": perMin,
    "total": total,
    "cab_find": cabFind,
    "driver_id": driverId,
  };
}
