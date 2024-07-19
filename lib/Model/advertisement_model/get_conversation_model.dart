class GetConversationModel {
  List<GetConversationResult>? result;
  String? message;
  int? status;

  GetConversationModel({this.result, this.message, this.status});

  GetConversationModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetConversationResult>[];
      json['result'].forEach((v) {
        result!.add(new GetConversationResult.fromJson(v));
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

class GetConversationResult {
  String? id;
  String? fullName;
  String? userName;
  String? mobile;
  String? email;
  String? password;
  String? image;
  String? type;
  String? status;
  String? socialId;
  String? registerId;
  String? token;
  String? expiredAt;
  String? lastLogin;
  String? dateTime;
  String? otp;
  String? lat;
  String? lon;
  String? notifiStatus;
  String? countryCode;
  String? userStep;
  int? noOfMessage;
  String? lastMessage;
  String? lastImage;
  String? date;
  String? time;
  String? senderId;
  String? receiverId;

  GetConversationResult(
      {this.id,
        this.fullName,
        this.userName,
        this.mobile,
        this.email,
        this.password,
        this.image,
        this.type,
        this.status,
        this.socialId,
        this.registerId,
        this.token,
        this.expiredAt,
        this.lastLogin,
        this.dateTime,
        this.otp,
        this.lat,
        this.lon,
        this.notifiStatus,
        this.countryCode,
        this.userStep,
        this.noOfMessage,
        this.lastMessage,
        this.lastImage,
        this.date,
        this.time,
        this.senderId,
        this.receiverId});

  GetConversationResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    userName = json['user_name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    type = json['type'];
    status = json['status'];
    socialId = json['social_id'];
    registerId = json['register_id'];
    token = json['token'];
    expiredAt = json['expired_at'];
    lastLogin = json['last_login'];
    dateTime = json['date_time'];
    otp = json['otp'];
    lat = json['lat'];
    lon = json['lon'];
    notifiStatus = json['notifi_status'];
    countryCode = json['country_code'];
    userStep = json['user_step'];
    noOfMessage = json['no_of_message'];
    lastMessage = json['last_message'];
    lastImage = json['last_image'];
    date = json['date'];
    time = json['time'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image'] = this.image;
    data['type'] = this.type;
    data['status'] = this.status;
    data['social_id'] = this.socialId;
    data['register_id'] = this.registerId;
    data['token'] = this.token;
    data['expired_at'] = this.expiredAt;
    data['last_login'] = this.lastLogin;
    data['date_time'] = this.dateTime;
    data['otp'] = this.otp;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['notifi_status'] = this.notifiStatus;
    data['country_code'] = this.countryCode;
    data['user_step'] = this.userStep;
    data['no_of_message'] = this.noOfMessage;
    data['last_message'] = this.lastMessage;
    data['last_image'] = this.lastImage;
    data['date'] = this.date;
    data['time'] = this.time;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    return data;
  }
}
