class GetPartsFilterModel {
  List<GetPartsFilterResult>? result;
  String? message;
  String? status;

  GetPartsFilterModel({this.result, this.message, this.status});

  GetPartsFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetPartsFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetPartsFilterResult.fromJson(v));
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

class GetPartsFilterResult {
  String? partId;
  String? partName;
  String? partCreatedAt;
  String? partUpdatedAt;
  Null? partDeletedAt;
  String? partAdminStatus;

  GetPartsFilterResult(
      {this.partId,
        this.partName,
        this.partCreatedAt,
        this.partUpdatedAt,
        this.partDeletedAt,
        this.partAdminStatus});

  GetPartsFilterResult.fromJson(Map<String, dynamic> json) {
    partId = json['part_id'];
    partName = json['part_name'];
    partCreatedAt = json['part_created_at'];
    partUpdatedAt = json['part_updated_at'];
    partDeletedAt = json['part_deleted_at'];
    partAdminStatus = json['part_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['part_id'] = this.partId;
    data['part_name'] = this.partName;
    data['part_created_at'] = this.partCreatedAt;
    data['part_updated_at'] = this.partUpdatedAt;
    data['part_deleted_at'] = this.partDeletedAt;
    data['part_admin_status'] = this.partAdminStatus;
    return data;
  }
}
