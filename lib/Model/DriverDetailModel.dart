class DriverDetailModel {
  DriverDetailResult result;
  String message;
  String status;

  DriverDetailModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory DriverDetailModel.fromJson(Map<String, dynamic> json) => DriverDetailModel(
    result: DriverDetailResult.fromJson(json["result"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "message": message,
    "status": status,
  };
}

class DriverDetailResult {
  String drId;
  String drFullName;
  String drEmail;
  String drMobile;
  String drCity;
  String drHome1;
  String drHome2;
  String drPassword;
  String drCountryCode;
  String drUploadVehicalPicture;
  String drUploadLicense;
  String drVehicalType;
  String drVehicalBrand;
  String drVehicalModel;
  String drNumberPlate;
  String drUploadDocuments;
  String drImage;
  String lat;
  String lon;
  String status;
  String image;
  List<Review> review;
  Range range;

  DriverDetailResult({
    required this.drId,
    required this.drFullName,
    required this.drEmail,
    required this.drMobile,
    required this.drCity,
    required this.drHome1,
    required this.drHome2,
    required this.drPassword,
    required this.drCountryCode,
    required this.drUploadVehicalPicture,
    required this.drUploadLicense,
    required this.drVehicalType,
    required this.drVehicalBrand,
    required this.drVehicalModel,
    required this.drNumberPlate,
    required this.drUploadDocuments,
    required this.drImage,
    required this.lat,
    required this.lon,
    required this.status,
    required this.image,
    required this.review,
    required this.range,
  });

  factory DriverDetailResult.fromJson(Map<String, dynamic> json) => DriverDetailResult(
    drId: json["dr_id"],
    drFullName: json["dr_full_name"],
    drEmail: json["dr_email"],
    drMobile: json["dr_mobile"],
    drCity: json["dr_city"],
    drHome1: json["dr_home_1"],
    drHome2: json["dr_home_2"],
    drPassword: json["dr_password"],
    drCountryCode: json["dr_country_code"],
    drUploadVehicalPicture: json["dr_upload_vehical_picture"],
    drUploadLicense: json["dr_upload_license"],
    drVehicalType: json["dr_vehical_type"],
    drVehicalBrand: json["dr_vehical_brand"],
    drVehicalModel: json["dr_vehical_model"],
    drNumberPlate: json["dr_number_plate"],
    drUploadDocuments: json["dr_upload_documents"],
    drImage: json["dr_image"],
    lat: json["lat"],
    lon: json["lon"],
    status: json["status"],
    image: json["image"]??"",
    review: List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
    range: Range.fromJson(json["range"]),
  );

  Map<String, dynamic> toJson() => {
    "dr_id": drId,
    "dr_full_name": drFullName,
    "dr_email": drEmail,
    "dr_mobile": drMobile,
    "dr_city": drCity,
    "dr_home_1": drHome1,
    "dr_home_2": drHome2,
    "dr_password": drPassword,
    "dr_country_code": drCountryCode,
    "dr_upload_vehical_picture": drUploadVehicalPicture,
    "dr_upload_license": drUploadLicense,
    "dr_vehical_type": drVehicalType,
    "dr_vehical_brand": drVehicalBrand,
    "dr_vehical_model": drVehicalModel,
    "dr_number_plate": drNumberPlate,
    "dr_upload_documents": drUploadDocuments,
    "dr_image": drImage,
    "lat": lat,
    "lon": lon,
    "status": status,
    "image": image,
    "review": List<dynamic>.from(review.map((x) => x.toJson())),
    "range": range.toJson(),
  };
}

class Range {
  String country;
  String city;

  Range({
    required this.country,
    required this.city,
  });

  factory Range.fromJson(Map<String, dynamic> json) => Range(
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "city": city,
  };
}

class Review {
  String reviewDriverId;
  String reviewDriverUserId;
  String reviewDriverDriverId;
  String reviewDriverRating;
  String reviewDriverComment;
  DateTime reviewDriverDateTime;
  String id;
  String fullName;
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

  Review({
    required this.reviewDriverId,
    required this.reviewDriverUserId,
    required this.reviewDriverDriverId,
    required this.reviewDriverRating,
    required this.reviewDriverComment,
    required this.reviewDriverDateTime,
    required this.id,
    required this.fullName,
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

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    reviewDriverId: json["review_driver_id"],
    reviewDriverUserId: json["review_driver_user_id"],
    reviewDriverDriverId: json["review_driver_driver_id"],
    reviewDriverRating: json["review_driver_rating"],
    reviewDriverComment: json["review_driver_comment"],
    reviewDriverDateTime: DateTime.parse(json["review_driver_date_time"]),
    id: json["id"],
    fullName: json["full_name"],
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
    "review_driver_id": reviewDriverId,
    "review_driver_user_id": reviewDriverUserId,
    "review_driver_driver_id": reviewDriverDriverId,
    "review_driver_rating": reviewDriverRating,
    "review_driver_comment": reviewDriverComment,
    "review_driver_date_time": reviewDriverDateTime.toIso8601String(),
    "id": id,
    "full_name": fullName,
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
