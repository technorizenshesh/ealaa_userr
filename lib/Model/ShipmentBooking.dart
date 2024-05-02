class ShipmentBookingModel {
  String result;
  String shipmentOrderId;
  String message;
  String status;

  ShipmentBookingModel({
    required this.result,
    required this.shipmentOrderId,
    required this.message,
    required this.status,
  });

  factory ShipmentBookingModel.fromJson(Map<String, dynamic> json) => ShipmentBookingModel(
    result: json["result"],
    shipmentOrderId: json["shipmentOrderId"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "shipmentOrderId": shipmentOrderId,
    "message": message,
    "status": status,
  };
}
