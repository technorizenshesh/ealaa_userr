class GetPlateTypesFilterModel {
  List<GetPlateTypesFilterResult>? result;
  String? message;
  String? status;

  GetPlateTypesFilterModel({this.result, this.message, this.status});

  GetPlateTypesFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetPlateTypesFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetPlateTypesFilterResult.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class GetPlateTypesFilterResult {
  String? plateTypeId;
  String? plateTypeName;
  String? plateTypeCreatedAt;
  String? plateTypeUpdatedAt;
  Null? plateTypeDeletedAt;
  String? plateTypeAdminStatus;

  GetPlateTypesFilterResult(
      {this.plateTypeId,
        this.plateTypeName,
        this.plateTypeCreatedAt,
        this.plateTypeUpdatedAt,
        this.plateTypeDeletedAt,
        this.plateTypeAdminStatus});

  GetPlateTypesFilterResult.fromJson(Map<String, dynamic> json) {
    plateTypeId = json['plate_type_id'];
    plateTypeName = json['plate_type_name'];
    plateTypeCreatedAt = json['plate_type_created_at'];
    plateTypeUpdatedAt = json['plate_type_updated_at'];
    plateTypeDeletedAt = json['plate_type_deleted_at'];
    plateTypeAdminStatus = json['plate_type_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plate_type_id'] = plateTypeId;
    data['plate_type_name'] = plateTypeName;
    data['plate_type_created_at'] = plateTypeCreatedAt;
    data['plate_type_updated_at'] = plateTypeUpdatedAt;
    data['plate_type_deleted_at'] = plateTypeDeletedAt;
    data['plate_type_admin_status'] = plateTypeAdminStatus;
    return data;
  }
}
