class GetStorePaymentModel {
  List<GetStorePaymentResult>? result;
  String? message;
  String? status;

  GetStorePaymentModel({this.result, this.message, this.status});

  GetStorePaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetStorePaymentResult>[];
      json['result'].forEach((v) {
        result!.add(new GetStorePaymentResult.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class GetStorePaymentResult {
  String? id;
  String? userId;
  String? shipmentId;
  String? amount;
  String? dateTime;
  String? sessionId;
  String? name;
  String? paymentStatus;
  String? driverId;
  String? shipmentType;
  String? addressId;
  String? orderDate;
  String? userName;
  String? mobile;
  String? image;

  GetStorePaymentResult(
      {this.id,
        this.userId,
        this.shipmentId,
        this.amount,
        this.dateTime,
        this.sessionId,
        this.name,
        this.paymentStatus,
        this.driverId,
        this.shipmentType,
        this.addressId,
        this.orderDate,
        this.userName,
        this.mobile,
        this.image});

  GetStorePaymentResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    shipmentId = json['shipment_id'];
    amount = json['amount'];
    dateTime = json['date_time'];
    sessionId = json['session_id'];
    name = json['name'];
    paymentStatus = json['payment_status'];
    driverId = json['driver_id'];
    shipmentType = json['shipment_type'];
    addressId = json['address_id'];
    orderDate = json['order_date'];
    userName = json['user_name'];
    mobile = json['mobile'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['shipment_id'] = this.shipmentId;
    data['amount'] = this.amount;
    data['date_time'] = this.dateTime;
    data['session_id'] = this.sessionId;
    data['name'] = this.name;
    data['payment_status'] = this.paymentStatus;
    data['driver_id'] = this.driverId;
    data['shipment_type'] = this.shipmentType;
    data['address_id'] = this.addressId;
    data['order_date'] = this.orderDate;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    return data;
  }
}
