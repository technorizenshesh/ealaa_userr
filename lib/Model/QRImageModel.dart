class QRImageModel {
  QRImageResult result;
  String message;
  String status;

  QRImageModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory QRImageModel.fromJson(Map<String, dynamic> json) => QRImageModel(
    result: QRImageResult.fromJson(json["result"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "message": message,
    "status": status,
  };
}

class QRImageResult {
  String shipmentDetailsId;
  String shipmentDetailsPhoto;
  String shipmentDetailsSenderName;
  String shipmentDetailsReceiverName;
  String shipmentDetailsLength;
  String shipmentDetailsWeight;
  String shipmentDetailsHeight;
  String shipmentDetailsPickLocation;
  String shipmentDetailsDropLocation;
  String shipmentDetailsReceiverPhoneNumber;
  String shipmentDetailsReceiverAddress1;
  String shipmentDetailsReceiverAddress2;
  String shipmentDetailsReceiverCountry;
  String shipmentDetailsReceiverCity;
  String shipmentDetailsReceiverPostalCode;
  String shipmentDetailsReceiverHouseNo;
  String shipmentDetailsDeleteStatus;
  String shipmentDetailsUsersId;
  String city;
  String vehicleId;
  String shipmentDetailsWidth;
  String shipmentDetailsWeightUnit;
  String shipmentDetailsSizeUnit;
  String shipmentPickLat;
  String shipmentPickLon;
  String shipmentDropLan;
  String shipmentDropLon;
  String companyId;
  String companyAmount;
  String shipmentStatus;
  String shipmentOrderId;
  String driversId;
  String status;
  DateTime dateTime;
  String shipmentType;
  String startTime;
  String completeTime;
  String qrImage;
  String qrCode;
  String paymentStatus;
  String qrImageSecond;
  String qrCodeSecond;
  String sendNotifi;
  String distance;
  int estimateTime;
  String qr1;

  QRImageResult({
    required this.shipmentDetailsId,
    required this.shipmentDetailsPhoto,
    required this.shipmentDetailsSenderName,
    required this.shipmentDetailsReceiverName,
    required this.shipmentDetailsLength,
    required this.shipmentDetailsWeight,
    required this.shipmentDetailsHeight,
    required this.shipmentDetailsPickLocation,
    required this.shipmentDetailsDropLocation,
    required this.shipmentDetailsReceiverPhoneNumber,
    required this.shipmentDetailsReceiverAddress1,
    required this.shipmentDetailsReceiverAddress2,
    required this.shipmentDetailsReceiverCountry,
    required this.shipmentDetailsReceiverCity,
    required this.shipmentDetailsReceiverPostalCode,
    required this.shipmentDetailsReceiverHouseNo,
    required this.shipmentDetailsDeleteStatus,
    required this.shipmentDetailsUsersId,
    required this.city,
    required this.vehicleId,
    required this.shipmentDetailsWidth,
    required this.shipmentDetailsWeightUnit,
    required this.shipmentDetailsSizeUnit,
    required this.shipmentPickLat,
    required this.shipmentPickLon,
    required this.shipmentDropLan,
    required this.shipmentDropLon,
    required this.companyId,
    required this.companyAmount,
    required this.shipmentStatus,
    required this.shipmentOrderId,
    required this.driversId,
    required this.status,
    required this.dateTime,
    required this.shipmentType,
    required this.startTime,
    required this.completeTime,
    required this.qrImage,
    required this.qrCode,
    required this.paymentStatus,
    required this.qrImageSecond,
    required this.qrCodeSecond,
    required this.sendNotifi,
    required this.distance,
    required this.estimateTime,
    required this.qr1,
  });

  factory QRImageResult.fromJson(Map<String, dynamic> json) => QRImageResult(
    shipmentDetailsId: json["shipment_details_id"],
    shipmentDetailsPhoto: json["shipment_details_photo"],
    shipmentDetailsSenderName: json["shipment_details_sender_name"],
    shipmentDetailsReceiverName: json["shipment_details_receiver_name"],
    shipmentDetailsLength: json["shipment_details_length"],
    shipmentDetailsWeight: json["shipment_details_weight"],
    shipmentDetailsHeight: json["shipment_details_height"],
    shipmentDetailsPickLocation: json["shipment_details_pick_location"],
    shipmentDetailsDropLocation: json["shipment_details_drop_location"],
    shipmentDetailsReceiverPhoneNumber: json["shipment_details_receiver_phone_number"],
    shipmentDetailsReceiverAddress1: json["shipment_details_receiver_address_1"],
    shipmentDetailsReceiverAddress2: json["shipment_details_receiver_address_2"],
    shipmentDetailsReceiverCountry: json["shipment_details_receiver_country"],
    shipmentDetailsReceiverCity: json["shipment_details_receiver_city"],
    shipmentDetailsReceiverPostalCode: json["shipment_details_receiver_postal_code"],
    shipmentDetailsReceiverHouseNo: json["shipment_details_receiver_house_no"],
    shipmentDetailsDeleteStatus: json["shipment_details_delete_status"],
    shipmentDetailsUsersId: json["shipment_details_users_id"],
    city: json["city"],
    vehicleId: json["vehicle_id"],
    shipmentDetailsWidth: json["shipment_details_width"],
    shipmentDetailsWeightUnit: json["shipment_details_weight_unit"],
    shipmentDetailsSizeUnit: json["shipment_details_size_unit"],
    shipmentPickLat: json["shipment_pick_lat"],
    shipmentPickLon: json["shipment_pick_lon"],
    shipmentDropLan: json["shipment_drop_lan"],
    shipmentDropLon: json["shipment_drop_lon"],
    companyId: json["company_id"],
    companyAmount: json["company_amount"],
    shipmentStatus: json["shipment_status"],
    shipmentOrderId: json["shipmentOrderId"],
    driversId: json["driversId"],
    status: json["status"],
    dateTime: DateTime.parse(json["date_time"]),
    shipmentType: json["shipment_type"],
    startTime: json["start_time"],
    completeTime: json["complete_time"],
    qrImage: json["qr_image"],
    qrCode: json["qr_code"],
    paymentStatus: json["payment_status"],
    qrImageSecond: json["qr_image_second"],
    qrCodeSecond: json["qr_code_second"],
    sendNotifi: json["send_notifi"],
    distance: json["distance"],
    estimateTime: json["estimate_time"],
    qr1: json["qr1"],
  );

  Map<String, dynamic> toJson() => {
    "shipment_details_id": shipmentDetailsId,
    "shipment_details_photo": shipmentDetailsPhoto,
    "shipment_details_sender_name": shipmentDetailsSenderName,
    "shipment_details_receiver_name": shipmentDetailsReceiverName,
    "shipment_details_length": shipmentDetailsLength,
    "shipment_details_weight": shipmentDetailsWeight,
    "shipment_details_height": shipmentDetailsHeight,
    "shipment_details_pick_location": shipmentDetailsPickLocation,
    "shipment_details_drop_location": shipmentDetailsDropLocation,
    "shipment_details_receiver_phone_number": shipmentDetailsReceiverPhoneNumber,
    "shipment_details_receiver_address_1": shipmentDetailsReceiverAddress1,
    "shipment_details_receiver_address_2": shipmentDetailsReceiverAddress2,
    "shipment_details_receiver_country": shipmentDetailsReceiverCountry,
    "shipment_details_receiver_city": shipmentDetailsReceiverCity,
    "shipment_details_receiver_postal_code": shipmentDetailsReceiverPostalCode,
    "shipment_details_receiver_house_no": shipmentDetailsReceiverHouseNo,
    "shipment_details_delete_status": shipmentDetailsDeleteStatus,
    "shipment_details_users_id": shipmentDetailsUsersId,
    "city": city,
    "vehicle_id": vehicleId,
    "shipment_details_width": shipmentDetailsWidth,
    "shipment_details_weight_unit": shipmentDetailsWeightUnit,
    "shipment_details_size_unit": shipmentDetailsSizeUnit,
    "shipment_pick_lat": shipmentPickLat,
    "shipment_pick_lon": shipmentPickLon,
    "shipment_drop_lan": shipmentDropLan,
    "shipment_drop_lon": shipmentDropLon,
    "company_id": companyId,
    "company_amount": companyAmount,
    "shipment_status": shipmentStatus,
    "shipmentOrderId": shipmentOrderId,
    "driversId": driversId,
    "status": status,
    "date_time": dateTime.toIso8601String(),
    "shipment_type": shipmentType,
    "start_time": startTime,
    "complete_time": completeTime,
    "qr_image": qrImage,
    "qr_code": qrCode,
    "payment_status": paymentStatus,
    "qr_image_second": qrImageSecond,
    "qr_code_second": qrCodeSecond,
    "send_notifi": sendNotifi,
    "distance": distance,
    "estimate_time": estimateTime,
    "qr1": qr1,
  };
}
