class GetNearbyCompanyModel {
  List<GetNearbyCompanyResult> result;
  String message;
  String status;

  GetNearbyCompanyModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory GetNearbyCompanyModel.fromJson(Map<String, dynamic> json) => GetNearbyCompanyModel(
    result: List<GetNearbyCompanyResult>.from(json["result"].map((x) => GetNearbyCompanyResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetNearbyCompanyResult {
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
  dynamic cmCompanyLicenceImage;
  String cmUploadDocuments;
  String cmCompanyDescription;
  String cmCompanyImage;
  String companyLat;
  String companyLon;
  String registerId;
  String vehiclesAmount;

  GetNearbyCompanyResult({
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
    required this.companyLat,
    required this.companyLon,
    required this.registerId,
    required this.vehiclesAmount,
  });

  factory GetNearbyCompanyResult.fromJson(Map<String, dynamic> json) => GetNearbyCompanyResult(
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
    companyLat: json["company_lat"],
    companyLon: json["company_lon"],
    registerId: json["register_id"],
    vehiclesAmount: json["vehicles_amount"],
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
    "company_lat": companyLat,
    "company_lon": companyLon,
    "register_id": registerId,
    "vehicles_amount": vehiclesAmount,
  };
}



