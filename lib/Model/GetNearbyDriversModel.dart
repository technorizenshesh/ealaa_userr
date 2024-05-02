class GetNearbyDriversModel {
  List<GetNearbyDriversResult> result;
  String message;
  String status;

  GetNearbyDriversModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory GetNearbyDriversModel.fromJson(Map<String, dynamic> json) => GetNearbyDriversModel(
    result: List<GetNearbyDriversResult>.from(json["result"].map((x) => GetNearbyDriversResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetNearbyDriversResult {
  String drId;
  String drFullName;
  String drEmail;
  String drMobile;
  String serviceType;
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
  String registerId;
  String numberPlateImage;
  String driverImage;
  String vehicleRegistrationImage;
  String sellerUploadPicture;
  String sellerStoreName;
  String sellerMobileNumber;
  String sellerAddress;
  String sellerLat;
  String sellerLon;
  String sellerBusinessType;
  String sellerEmail;
  String onlineStatus;
  String distance;
  int estimateTime;

  GetNearbyDriversResult({
    required this.drId,
    required this.drFullName,
    required this.drEmail,
    required this.drMobile,
    required this.serviceType,
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
    required this.registerId,
    required this.numberPlateImage,
    required this.driverImage,
    required this.vehicleRegistrationImage,
    required this.sellerUploadPicture,
    required this.sellerStoreName,
    required this.sellerMobileNumber,
    required this.sellerAddress,
    required this.sellerLat,
    required this.sellerLon,
    required this.sellerBusinessType,
    required this.sellerEmail,
    required this.onlineStatus,
    required this.distance,
    required this.estimateTime,
  });

  factory GetNearbyDriversResult.fromJson(Map<String, dynamic> json) => GetNearbyDriversResult(
    drId: json["dr_id"],
    drFullName: json["dr_full_name"],
    drEmail: json["dr_email"],
    drMobile: json["dr_mobile"],
    serviceType: json["service_type"],
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
    registerId: json["register_id"],
    numberPlateImage: json["number_plate_image"],
    driverImage: json["driver_image"],
    vehicleRegistrationImage: json["vehicle_registration_image"],
    sellerUploadPicture: json["seller_upload_picture"],
    sellerStoreName: json["seller_store_name"],
    sellerMobileNumber: json["seller_mobile_number"],
    sellerAddress: json["seller_address"],
    sellerLat: json["seller_lat"],
    sellerLon: json["seller_lon"],
    sellerBusinessType: json["seller_business_type"],
    sellerEmail: json["seller_email"],
    onlineStatus: json["online_status"],
    distance: json["distance"],
    estimateTime: json["estimate_time"],
  );

  Map<String, dynamic> toJson() => {
    "dr_id": drId,
    "dr_full_name": drFullName,
    "dr_email": drEmail,
    "dr_mobile": drMobile,
    "service_type": serviceType,
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
    "register_id": registerId,
    "number_plate_image": numberPlateImage,
    "driver_image": driverImage,
    "vehicle_registration_image": vehicleRegistrationImage,
    "seller_upload_picture": sellerUploadPicture,
    "seller_store_name": sellerStoreName,
    "seller_mobile_number": sellerMobileNumber,
    "seller_address": sellerAddress,
    "seller_lat": sellerLat,
    "seller_lon": sellerLon,
    "seller_business_type": sellerBusinessType,
    "seller_email": sellerEmail,
    "online_status": onlineStatus,
    "distance": distance,
    "estimate_time": estimateTime,
  };
}
