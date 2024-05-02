class CompanyDetailModel {
  CompanyDetailResult result;
  String message;
  String status;

  CompanyDetailModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory CompanyDetailModel.fromJson(Map<String, dynamic> json) => CompanyDetailModel(
    result: CompanyDetailResult.fromJson(json["result"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "message": message,
    "status": status,
  };
}

class CompanyDetailResult {
  String cmId;
  String cmName;
  String cmEmail;
  String cmMobileNo;
  String cmCountryCode;
  String cmPassword;
  String cmCompanyName;
  String cmCompanyCode;
  String cmCompanyMail;
  String cmCompanyAddress;
  String cmCompanyNumber;
  String cmCompanyLicenceImage;
  String cmUploadDocuments;
  String cmCompanyDescription;
  String cmCompanyImage;
  List<Review> review;
  Range range;

  CompanyDetailResult({
    required this.cmId,
    required this.cmName,
    required this.cmEmail,
    required this.cmMobileNo,
    required this.cmCountryCode,
    required this.cmPassword,
    required this.cmCompanyName,
    required this.cmCompanyCode,
    required this.cmCompanyMail,
    required this.cmCompanyAddress,
    required this.cmCompanyNumber,
    required this.cmCompanyLicenceImage,
    required this.cmUploadDocuments,
    required this.cmCompanyDescription,
    required this.cmCompanyImage,
    required this.review,
    required this.range,
  });

  factory CompanyDetailResult.fromJson(Map<String, dynamic> json) => CompanyDetailResult(
    cmId: json["cm_id"],
    cmName: json["cm_name"],
    cmEmail: json["cm_email"],
    cmMobileNo: json["cm_mobile_no"],
    cmCountryCode: json["cm_country_code"],
    cmPassword: json["cm_password"],
    cmCompanyName: json["cm_company_name"],
    cmCompanyCode: json["cm_company_code"],
    cmCompanyMail: json["cm_company_mail"],
    cmCompanyAddress: json["cm_company_address"],
    cmCompanyNumber: json["cm_company_number"],
    cmCompanyLicenceImage: json["cm_company_licence_image"],
    cmUploadDocuments: json["cm_upload_documents"],
    cmCompanyDescription: json["cm_company_description"],
    cmCompanyImage: json["cm_company_image"],
    review: List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
    range: Range.fromJson(json["range"]),
  );

  Map<String, dynamic> toJson() => {
    "cm_id": cmId,
    "cm_name": cmName,
    "cm_email": cmEmail,
    "cm_mobile_no": cmMobileNo,
    "cm_country_code": cmCountryCode,
    "cm_password": cmPassword,
    "cm_company_name": cmCompanyName,
    "cm_company_code": cmCompanyCode,
    "cm_company_mail": cmCompanyMail,
    "cm_company_address": cmCompanyAddress,
    "cm_company_number": cmCompanyNumber,
    "cm_company_licence_image": cmCompanyLicenceImage,
    "cm_upload_documents": cmUploadDocuments,
    "cm_company_description": cmCompanyDescription,
    "cm_company_image": cmCompanyImage,
    "review": List<dynamic>.from(review.map((x) => x.toJson())),
    "range": range.toJson(),
  };
}

class Range {
  List<Country> country;
  List<City> city;
  List<Vehical> vehical;

  Range({
    required this.country,
    required this.city,
    required this.vehical,
  });

  factory Range.fromJson(Map<String, dynamic> json) => Range(
    country: List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
    city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
    vehical: List<Vehical>.from(json["vehical"].map((x) => Vehical.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "country": List<dynamic>.from(country.map((x) => x.toJson())),
    "city": List<dynamic>.from(city.map((x) => x.toJson())),
    "vehical": List<dynamic>.from(vehical.map((x) => x.toJson())),
  };
}

class City {
  String id;
  String name;
  String stateId;
  String countryId;
  String status;

  City({
    required this.id,
    required this.name,
    required this.stateId,
    required this.countryId,
    required this.status,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    countryId: json["country_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "country_id": countryId,
    "status": status,
  };
}

class Country {
  String cscId;
  String cscCompanyId;
  String cscCountryId;
  String id;
  String iso;
  String name;
  String nicename;
  String iso3;
  String numcode;
  String phonecode;

  Country({
    required this.cscId,
    required this.cscCompanyId,
    required this.cscCountryId,
    required this.id,
    required this.iso,
    required this.name,
    required this.nicename,
    required this.iso3,
    required this.numcode,
    required this.phonecode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    cscId: json["csc_id"],
    cscCompanyId: json["csc_company_id"],
    cscCountryId: json["csc_country_id"],
    id: json["id"],
    iso: json["iso"],
    name: json["name"],
    nicename: json["nicename"],
    iso3: json["iso3"],
    numcode: json["numcode"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "csc_id": cscId,
    "csc_company_id": cscCompanyId,
    "csc_country_id": cscCountryId,
    "id": id,
    "iso": iso,
    "name": name,
    "nicename": nicename,
    "iso3": iso3,
    "numcode": numcode,
    "phonecode": phonecode,
  };
}

class Vehical {
  String vcId;
  String vcComanyId;
  String vcVehicalCategroyId;
  String vehiclesCategoryId;
  String vehiclesCategoryName;

  Vehical({
    required this.vcId,
    required this.vcComanyId,
    required this.vcVehicalCategroyId,
    required this.vehiclesCategoryId,
    required this.vehiclesCategoryName,
  });

  factory Vehical.fromJson(Map<String, dynamic> json) => Vehical(
    vcId: json["vc_id"],
    vcComanyId: json["vc_comany_id"],
    vcVehicalCategroyId: json["vc_vehical_categroy_id"],
    vehiclesCategoryId: json["vehicles_category_id"],
    vehiclesCategoryName: json["vehicles_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "vc_id": vcId,
    "vc_comany_id": vcComanyId,
    "vc_vehical_categroy_id": vcVehicalCategroyId,
    "vehicles_category_id": vehiclesCategoryId,
    "vehicles_category_name": vehiclesCategoryName,
  };
}

class Review {
  String reviewCompanyId;
  String reviewCompanyUserId;
  String reviewCompanyCompanyId;
  String reviewCompanyRating;
  String reviewCompanyComment;
  DateTime reviewCompanyDateTime;
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
    required this.reviewCompanyId,
    required this.reviewCompanyUserId,
    required this.reviewCompanyCompanyId,
    required this.reviewCompanyRating,
    required this.reviewCompanyComment,
    required this.reviewCompanyDateTime,
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
    reviewCompanyId: json["review_company_id"],
    reviewCompanyUserId: json["review_company_user_id"],
    reviewCompanyCompanyId: json["review_company_company_id"],
    reviewCompanyRating: json["review_company_rating"],
    reviewCompanyComment: json["review_company_comment"],
    reviewCompanyDateTime: DateTime.parse(json["review_company_date_time"]),
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
    "review_company_id": reviewCompanyId,
    "review_company_user_id": reviewCompanyUserId,
    "review_company_company_id": reviewCompanyCompanyId,
    "review_company_rating": reviewCompanyRating,
    "review_company_comment": reviewCompanyComment,
    "review_company_date_time": reviewCompanyDateTime.toIso8601String(),
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
