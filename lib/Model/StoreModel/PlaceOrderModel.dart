class PlaceOrderModel {
  PlaceOrderResult? result;
  String message;
  String status;

  PlaceOrderModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => PlaceOrderModel(
    result: json["result"]==null?null:PlaceOrderResult.fromJson(json["result"]),
    message: json["message"],
    status: json["status"],
  );

}

class PlaceOrderResult {
  String id;
  String userId;
  String productId;
  String amount;
  DateTime orderDate;
  String orderTime;
  String cartId;
  DateTime dateTime;
  String storeId;

  PlaceOrderResult({
    required this.id,
    required this.userId,
    required this.productId,
    required this.amount,
    required this.orderDate,
    required this.orderTime,
    required this.cartId,
    required this.dateTime,
    required this.storeId,
  });

  factory PlaceOrderResult.fromJson(Map<String, dynamic> json) => PlaceOrderResult(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    amount: json["amount"],
    orderDate: DateTime.parse(json["order_date"]),
    orderTime: json["order_time"],
    cartId: json["cart_id"],
    dateTime: DateTime.parse(json["date_time"]),
    storeId: json["store_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "amount": amount,
    "order_date": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "order_time": orderTime,
    "cart_id": cartId,
    "date_time": dateTime.toIso8601String(),
    "store_id": storeId,
  };
}


// class PlaceOrderModel {
//   PlaceOrderResult? result;
//   String message;
//   String status;
//
//   PlaceOrderModel({
//     required this.result,
//     required this.message,
//     required this.status,
//   });
//
//   factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => PlaceOrderModel(
//     result: json["result"]==null?null:PlaceOrderResult.fromJson(json["result"]),
//     message: json["message"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "result": result!.toJson(),
//     "message": message,
//     "status": status,
//   };
// }
//
// class PlaceOrderResult {
//   String id;
//   String fullName;
//   String userName;
//   String mobile;
//   String email;
//   String password;
//   String image;
//   String type;
//   String status;
//   String socialId;
//   String registerId;
//   String token;
//   DateTime expiredAt;
//   DateTime lastLogin;
//   DateTime dateTime;
//   String otp;
//   String lat;
//   String lon;
//   String notifiStatus;
//
//   PlaceOrderResult({
//     required this.id,
//     required this.fullName,
//     required this.userName,
//     required this.mobile,
//     required this.email,
//     required this.password,
//     required this.image,
//     required this.type,
//     required this.status,
//     required this.socialId,
//     required this.registerId,
//     required this.token,
//     required this.expiredAt,
//     required this.lastLogin,
//     required this.dateTime,
//     required this.otp,
//     required this.lat,
//     required this.lon,
//     required this.notifiStatus,
//   });
//
//   factory PlaceOrderResult.fromJson(Map<String, dynamic> json) => PlaceOrderResult(
//     id: json["id"],
//     fullName: json["full_name"],
//     userName: json["user_name"],
//     mobile: json["mobile"],
//     email: json["email"],
//     password: json["password"],
//     image: json["image"],
//     type: json["type"],
//     status: json["status"],
//     socialId: json["social_id"],
//     registerId: json["register_id"],
//     token: json["token"],
//     expiredAt: DateTime.parse(json["expired_at"]),
//     lastLogin: DateTime.parse(json["last_login"]),
//     dateTime: DateTime.parse(json["date_time"]),
//     otp: json["otp"],
//     lat: json["lat"],
//     lon: json["lon"],
//     notifiStatus: json["notifi_status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "full_name": fullName,
//     "user_name": userName,
//     "mobile": mobile,
//     "email": email,
//     "password": password,
//     "image": image,
//     "type": type,
//     "status": status,
//     "social_id": socialId,
//     "register_id": registerId,
//     "token": token,
//     "expired_at": expiredAt.toIso8601String(),
//     "last_login": lastLogin.toIso8601String(),
//     "date_time": dateTime.toIso8601String(),
//     "otp": otp,
//     "lat": lat,
//     "lon": lon,
//     "notifi_status": notifiStatus,
//   };
// }
