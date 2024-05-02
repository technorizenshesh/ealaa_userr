class GetStoreByCategoryModel {
  List<GetStoreByCategoryResult>? result;
  String? message;
  String? status;

  GetStoreByCategoryModel({this.result, this.message, this.status});

  GetStoreByCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetStoreByCategoryResult>[];
      json['result'].forEach((v) {
        result!.add(new GetStoreByCategoryResult.fromJson(v));
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

class GetStoreByCategoryResult {
  String? drId;
  String? drFullName;
  String? drEmail;
  String? drMobile;
  String? serviceType;
  String? drCity;
  String? drHome1;
  String? drHome2;
  String? drPassword;
  String? drCountryCode;
  Null? drUploadVehicalPicture;
  Null? drUploadLicense;
  Null? drVehicalType;
  Null? drVehicalBrand;
  Null? drVehicalModel;
  Null? drNumberPlate;
  String? drUploadDocuments;
  String? drImage;
  String? lat;
  String? lon;
  String? status;
  String? registerId;
  String? numberPlateImage;
  String? driverImage;
  String? vehicleRegistrationImage;
  String? sellerUploadPicture;
  String? sellerStoreName;
  String? sellerMobileNumber;
  String? sellerAddress;
  String? sellerLat;
  String? sellerLon;
  String? sellerBusinessType;
  String? sellerEmail;
  String? onlineStatus;
  String? notifiStatus;
  String? categoryId;
  String? storeDesc;
  String? wishListStatus;
  String? categoryName;
  String? productImage;

  GetStoreByCategoryResult(
      {this.drId,
        this.drFullName,
        this.drEmail,
        this.drMobile,
        this.serviceType,
        this.drCity,
        this.drHome1,
        this.drHome2,
        this.drPassword,
        this.drCountryCode,
        this.drUploadVehicalPicture,
        this.drUploadLicense,
        this.drVehicalType,
        this.drVehicalBrand,
        this.drVehicalModel,
        this.drNumberPlate,
        this.drUploadDocuments,
        this.drImage,
        this.lat,
        this.lon,
        this.status,
        this.registerId,
        this.numberPlateImage,
        this.driverImage,
        this.vehicleRegistrationImage,
        this.sellerUploadPicture,
        this.sellerStoreName,
        this.sellerMobileNumber,
        this.sellerAddress,
        this.sellerLat,
        this.sellerLon,
        this.sellerBusinessType,
        this.sellerEmail,
        this.onlineStatus,
        this.notifiStatus,
        this.categoryId,
        this.storeDesc,
        this.wishListStatus,
        this.categoryName,
        this.productImage});

  GetStoreByCategoryResult.fromJson(Map<String, dynamic> json) {
    drId = json['dr_id'];
    drFullName = json['dr_full_name'];
    drEmail = json['dr_email'];
    drMobile = json['dr_mobile'];
    serviceType = json['service_type'];
    drCity = json['dr_city'];
    drHome1 = json['dr_home_1'];
    drHome2 = json['dr_home_2'];
    drPassword = json['dr_password'];
    drCountryCode = json['dr_country_code'];
    drUploadVehicalPicture = json['dr_upload_vehical_picture'];
    drUploadLicense = json['dr_upload_license'];
    drVehicalType = json['dr_vehical_type'];
    drVehicalBrand = json['dr_vehical_brand'];
    drVehicalModel = json['dr_vehical_model'];
    drNumberPlate = json['dr_number_plate'];
    drUploadDocuments = json['dr_upload_documents'];
    drImage = json['dr_image'];
    lat = json['lat'];
    lon = json['lon'];
    status = json['status'];
    registerId = json['register_id'];
    numberPlateImage = json['number_plate_image'];
    driverImage = json['driver_image'];
    vehicleRegistrationImage = json['vehicle_registration_image'];
    sellerUploadPicture = json['seller_upload_picture'];
    sellerStoreName = json['seller_store_name'];
    sellerMobileNumber = json['seller_mobile_number'];
    sellerAddress = json['seller_address'];
    sellerLat = json['seller_lat'];
    sellerLon = json['seller_lon'];
    sellerBusinessType = json['seller_business_type'];
    sellerEmail = json['seller_email'];
    onlineStatus = json['online_status'];
    notifiStatus = json['notifi_status'];
    categoryId = json['category_id'];
    storeDesc = json['store_desc'];
    wishListStatus = json['wish_list_status'];
    categoryName = json['category_name'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dr_id'] = this.drId;
    data['dr_full_name'] = this.drFullName;
    data['dr_email'] = this.drEmail;
    data['dr_mobile'] = this.drMobile;
    data['service_type'] = this.serviceType;
    data['dr_city'] = this.drCity;
    data['dr_home_1'] = this.drHome1;
    data['dr_home_2'] = this.drHome2;
    data['dr_password'] = this.drPassword;
    data['dr_country_code'] = this.drCountryCode;
    data['dr_upload_vehical_picture'] = this.drUploadVehicalPicture;
    data['dr_upload_license'] = this.drUploadLicense;
    data['dr_vehical_type'] = this.drVehicalType;
    data['dr_vehical_brand'] = this.drVehicalBrand;
    data['dr_vehical_model'] = this.drVehicalModel;
    data['dr_number_plate'] = this.drNumberPlate;
    data['dr_upload_documents'] = this.drUploadDocuments;
    data['dr_image'] = this.drImage;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['status'] = this.status;
    data['register_id'] = this.registerId;
    data['number_plate_image'] = this.numberPlateImage;
    data['driver_image'] = this.driverImage;
    data['vehicle_registration_image'] = this.vehicleRegistrationImage;
    data['seller_upload_picture'] = this.sellerUploadPicture;
    data['seller_store_name'] = this.sellerStoreName;
    data['seller_mobile_number'] = this.sellerMobileNumber;
    data['seller_address'] = this.sellerAddress;
    data['seller_lat'] = this.sellerLat;
    data['seller_lon'] = this.sellerLon;
    data['seller_business_type'] = this.sellerBusinessType;
    data['seller_email'] = this.sellerEmail;
    data['online_status'] = this.onlineStatus;
    data['notifi_status'] = this.notifiStatus;
    data['category_id'] = this.categoryId;
    data['store_desc'] = this.storeDesc;
    data['wish_list_status'] = this.wishListStatus;
    data['category_name'] = this.categoryName;
    data['product_image'] = this.productImage;
    return data;
  }
}
