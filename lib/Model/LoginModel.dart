class LoginModel {
  LoginResult result;
  String message;
  String status;

  LoginModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    result: LoginResult.fromJson(json["result"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "message": message,
    "status": status,
  };
}

class LoginResult {
  String id;
  String userName;
  String mobile;
  String email;
  String password;
  String image;
  String type;
  String status;
  String socialId;
  String registerId;
  String token;
  DateTime expiredAt;
  DateTime lastLogin;
  DateTime dateTime;
  String otp;

  LoginResult({
    required this.id,
    required this.userName,
    required this.mobile,
    required this.email,
    required this.password,
    required this.image,
    required this.type,
    required this.status,
    required this.socialId,
    required this.registerId,
    required this.token,
    required this.expiredAt,
    required this.lastLogin,
    required this.dateTime,
    required this.otp,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
    id: json["id"],
    userName: json["user_name"],
    mobile: json["mobile"],
    email: json["email"],
    password: json["password"],
    image: json["image"],
    type: json["type"],
    status: json["status"],
    socialId: json["social_id"],
    registerId: json["register_id"],
    token: json["token"],
    expiredAt: DateTime.parse(json["expired_at"]),
    lastLogin: DateTime.parse(json["last_login"]),
    dateTime: DateTime.parse(json["date_time"]),
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "mobile": mobile,
    "email": email,
    "password": password,
    "image": image,
    "type": type,
    "status": status,
    "social_id": socialId,
    "register_id": registerId,
    "token": token,
    "expired_at": expiredAt.toIso8601String(),
    "last_login": lastLogin.toIso8601String(),
    "date_time": dateTime.toIso8601String(),
    "otp": otp,
  };
}
