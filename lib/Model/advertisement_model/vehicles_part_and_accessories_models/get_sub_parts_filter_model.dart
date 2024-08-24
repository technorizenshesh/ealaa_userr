class GetSubPartsFilterModel {
  List<GetSubPartsFilterResult>? result;
  String? message;
  String? status;

  GetSubPartsFilterModel({this.result, this.message, this.status});

  GetSubPartsFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetSubPartsFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetSubPartsFilterResult.fromJson(v));
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

class GetSubPartsFilterResult {
  String? subPartId;
  String? partId;
  String? subPartName;
  String? subPartCreatedAt;
  String? subPartUpdatedAt;
  Null? subPartDeletedAt;
  String? subPartAdminStatus;

  GetSubPartsFilterResult(
      {this.subPartId,
        this.partId,
        this.subPartName,
        this.subPartCreatedAt,
        this.subPartUpdatedAt,
        this.subPartDeletedAt,
        this.subPartAdminStatus});

  GetSubPartsFilterResult.fromJson(Map<String, dynamic> json) {
    subPartId = json['sub_part_id'];
    partId = json['part_id'];
    subPartName = json['sub_part_name'];
    subPartCreatedAt = json['sub_part_created_at'];
    subPartUpdatedAt = json['sub_part_updated_at'];
    subPartDeletedAt = json['sub_part_deleted_at'];
    subPartAdminStatus = json['sub_part_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_part_id'] = this.subPartId;
    data['part_id'] = this.partId;
    data['sub_part_name'] = this.subPartName;
    data['sub_part_created_at'] = this.subPartCreatedAt;
    data['sub_part_updated_at'] = this.subPartUpdatedAt;
    data['sub_part_deleted_at'] = this.subPartDeletedAt;
    data['sub_part_admin_status'] = this.subPartAdminStatus;
    return data;
  }
}
