class NotificationModel {
  List<NotificationResult> result;
  String message;
  String status;

  NotificationModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    result: List<NotificationResult>.from(json["result"].map((x) => NotificationResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class NotificationResult {
  String id;
  String userId;
  String message;
  String driverId;
  DateTime dateTime;
  String shipmentId;
  String status;
  String type;
  String userName;
  String image;

  NotificationResult({
    required this.id,
    required this.userId,
    required this.message,
    required this.driverId,
    required this.dateTime,
    required this.shipmentId,
    required this.status,
    required this.type,
    required this.userName,
    required this.image,
  });

  factory NotificationResult.fromJson(Map<String, dynamic> json) => NotificationResult(
    id: json["id"],
    userId: json["user_id"],
    message: json["message"],
    driverId: json["driver_id"],
    dateTime: DateTime.parse(json["date_time"]),
    shipmentId: json["shipment_id"],
    status: json["status"],
    type: json["type"],
    userName: json["user_name"],
    image: json["shipment_details_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "message": message,
    "driver_id": driverId,
    "date_time": dateTime.toIso8601String(),
    "shipment_id": shipmentId,
    "status": status,
    "type": type,
    "user_name": userName,
    "image": image,
  };
}
