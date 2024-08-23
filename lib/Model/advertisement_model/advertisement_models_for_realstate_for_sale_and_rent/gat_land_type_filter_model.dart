class GetLandTypesFilterModel {
  List<GetLandTypesFilterResult>? result;
  String? message;
  String? status;

  GetLandTypesFilterModel({this.result, this.message, this.status});

  GetLandTypesFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetLandTypesFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetLandTypesFilterResult.fromJson(v));
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

class GetLandTypesFilterResult {
  String? landtypeId;
  String? landtypeName;
  String? landtypeCreatedAt;
  String? landtypeUpdatedAt;
  String? landtypeAdminStatus;

  GetLandTypesFilterResult(
      {this.landtypeId,
        this.landtypeName,
        this.landtypeCreatedAt,
        this.landtypeUpdatedAt,
        this.landtypeAdminStatus});

  GetLandTypesFilterResult.fromJson(Map<String, dynamic> json) {
    landtypeId = json['landtype_id'];
    landtypeName = json['landtype_name'];
    landtypeCreatedAt = json['landtype_created_at'];
    landtypeUpdatedAt = json['landtype_updated_at'];
    landtypeAdminStatus = json['landtype_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['landtype_id'] = this.landtypeId;
    data['landtype_name'] = this.landtypeName;
    data['landtype_created_at'] = this.landtypeCreatedAt;
    data['landtype_updated_at'] = this.landtypeUpdatedAt;
    data['landtype_admin_status'] = this.landtypeAdminStatus;
    return data;
  }
}
