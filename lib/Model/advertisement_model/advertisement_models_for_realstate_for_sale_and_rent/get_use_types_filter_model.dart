class GetUseTypesFilterModel {
  List<GetUseTypesFilterResult>? result;
  String? message;
  String? status;

  GetUseTypesFilterModel({this.result, this.message, this.status});

  GetUseTypesFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetUseTypesFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetUseTypesFilterResult.fromJson(v));
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

class GetUseTypesFilterResult {
  String? useId;
  String? useName;
  String? useCreatedAt;
  String? useUpdatedAt;
  String? useAdminStatus;

  GetUseTypesFilterResult(
      {this.useId,
      this.useName,
      this.useCreatedAt,
      this.useUpdatedAt,
      this.useAdminStatus});

  GetUseTypesFilterResult.fromJson(Map<String, dynamic> json) {
    useId = json['use_id'];
    useName = json['use_name'];
    useCreatedAt = json['use_created_at'];
    useUpdatedAt = json['use_updated_at'];
    useAdminStatus = json['use_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['use_id'] = this.useId;
    data['use_name'] = this.useName;
    data['use_created_at'] = this.useCreatedAt;
    data['use_updated_at'] = this.useUpdatedAt;
    data['use_admin_status'] = this.useAdminStatus;
    return data;
  }
}
