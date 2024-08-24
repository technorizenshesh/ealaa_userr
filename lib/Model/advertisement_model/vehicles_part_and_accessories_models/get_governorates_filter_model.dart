class GetGovernoratesFilterModel {
  List<GetGovernoratesFilterResult>? result;
  String? message;
  String? status;

  GetGovernoratesFilterModel({this.result, this.message, this.status});

  GetGovernoratesFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetGovernoratesFilterResult>[];
      json['result'].forEach((v) {
        result!.add(GetGovernoratesFilterResult.fromJson(v));
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

class GetGovernoratesFilterResult {
  String? governorateId;
  String? governorateName;
  String? governorateCreatedAt;
  String? governorateUpdatedAt;
  Null? governorateDeletedAt;
  String? governorateAdminStatus;

  GetGovernoratesFilterResult(
      {this.governorateId,
        this.governorateName,
        this.governorateCreatedAt,
        this.governorateUpdatedAt,
        this.governorateDeletedAt,
        this.governorateAdminStatus});

  GetGovernoratesFilterResult.fromJson(Map<String, dynamic> json) {
    governorateId = json['governorate_id'];
    governorateName = json['governorate_name'];
    governorateCreatedAt = json['governorate_created_at'];
    governorateUpdatedAt = json['governorate_updated_at'];
    governorateDeletedAt = json['governorate_deleted_at'];
    governorateAdminStatus = json['governorate_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['governorate_id'] = this.governorateId;
    data['governorate_name'] = this.governorateName;
    data['governorate_created_at'] = this.governorateCreatedAt;
    data['governorate_updated_at'] = this.governorateUpdatedAt;
    data['governorate_deleted_at'] = this.governorateDeletedAt;
    data['governorate_admin_status'] = this.governorateAdminStatus;
    return data;
  }
}
