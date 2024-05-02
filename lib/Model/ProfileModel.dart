class ProfileModel {
  ProfileResult? result;
  String? message;
  String? status;

  ProfileModel({this.result, this.message, this.status});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new ProfileResult.fromJson(json['result']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class ProfileResult {
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

  ProfileResult(
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
        this.userStep});

  ProfileResult.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
