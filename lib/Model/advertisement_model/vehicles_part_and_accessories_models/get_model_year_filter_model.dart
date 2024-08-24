class GetModelYearFilterModel {
  List<GetModelYearFilterResult>? result;
  String? message;
  String? status;

  GetModelYearFilterModel({this.result, this.message, this.status});

  GetModelYearFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetModelYearFilterResult>[];
      json['result'].forEach((v) {
        result!.add(GetModelYearFilterResult.fromJson(v));
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

class GetModelYearFilterResult {
  String? yearId;
  String? yearName;
  String? yearCreatedAt;
  String? yearUpdatedAt;
  Null? yearDeletedAt;
  String? yearAdminStatus;

  GetModelYearFilterResult(
      {this.yearId,
        this.yearName,
        this.yearCreatedAt,
        this.yearUpdatedAt,
        this.yearDeletedAt,
        this.yearAdminStatus});

  GetModelYearFilterResult.fromJson(Map<String, dynamic> json) {
    yearId = json['year_id'];
    yearName = json['year_name'];
    yearCreatedAt = json['year_created_at'];
    yearUpdatedAt = json['year_updated_at'];
    yearDeletedAt = json['year_deleted_at'];
    yearAdminStatus = json['year_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year_id'] = this.yearId;
    data['year_name'] = this.yearName;
    data['year_created_at'] = this.yearCreatedAt;
    data['year_updated_at'] = this.yearUpdatedAt;
    data['year_deleted_at'] = this.yearDeletedAt;
    data['year_admin_status'] = this.yearAdminStatus;
    return data;
  }
}
