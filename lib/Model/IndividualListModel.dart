class IndividualListModel {
  List<IndividualListResult> result;
  String message;
  String status;

  IndividualListModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory IndividualListModel.fromJson(Map<String, dynamic> json) => IndividualListModel(
    result: List<IndividualListResult>.from(json["result"].map((x) => IndividualListResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class IndividualListResult {
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

  IndividualListResult({
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
  });

  factory IndividualListResult.fromJson(Map<String, dynamic> json) => IndividualListResult(
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
  };
}
