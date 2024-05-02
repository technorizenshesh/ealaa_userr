class AddAddressModel {
  List<AddAddressResult> result;
  String message;
  String status;

  AddAddressModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory AddAddressModel.fromJson(Map<String, dynamic> json) => AddAddressModel(
    result: List<AddAddressResult>.from(json["result"].map((x) => AddAddressResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class AddAddressResult {
  String id;
  String userId;
  String address;
  String lat;
  String lon;
  DateTime dateTime;
  String consigneeName;
  String phoneNumber;

  AddAddressResult({
    required this.id,
    required this.userId,
    required this.address,
    required this.lat,
    required this.lon,
    required this.dateTime,
    required this.consigneeName,
    required this.phoneNumber,
  });

  factory AddAddressResult.fromJson(Map<String, dynamic> json) => AddAddressResult(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    lat: json["lat"],
    lon: json["lon"],
    dateTime: DateTime.parse(json["date_time"]),
    consigneeName: json["consignee_name"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "lat": lat,
    "lon": lon,
    "date_time": dateTime.toIso8601String(),
    "consignee_name": consigneeName,
    "phone_number": phoneNumber,
  };
}
