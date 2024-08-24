class GetModelEnginesFilterModel {
  List<GetModelEnginesFilterResult>? result;
  String? message;
  String? status;

  GetModelEnginesFilterModel({this.result, this.message, this.status});

  GetModelEnginesFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetModelEnginesFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetModelEnginesFilterResult.fromJson(v));
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

class GetModelEnginesFilterResult {
  String? engineId;
  String? engineValue;
  String? engineCreatedAt;
  String? engineUpdatedAt;
  Null? engineDeletedAt;
  String? engineAdminStatus;
  String? modelTrimId;

  GetModelEnginesFilterResult(
      {this.engineId,
        this.engineValue,
        this.engineCreatedAt,
        this.engineUpdatedAt,
        this.engineDeletedAt,
        this.engineAdminStatus,
        this.modelTrimId});

  GetModelEnginesFilterResult.fromJson(Map<String, dynamic> json) {
    engineId = json['engine_id'];
    engineValue = json['engine_value'];
    engineCreatedAt = json['engine_created_at'];
    engineUpdatedAt = json['engine_updated_at'];
    engineDeletedAt = json['engine_deleted_at'];
    engineAdminStatus = json['engine_admin_status'];
    modelTrimId = json['model_trim_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['engine_id'] = this.engineId;
    data['engine_value'] = this.engineValue;
    data['engine_created_at'] = this.engineCreatedAt;
    data['engine_updated_at'] = this.engineUpdatedAt;
    data['engine_deleted_at'] = this.engineDeletedAt;
    data['engine_admin_status'] = this.engineAdminStatus;
    data['model_trim_id'] = this.modelTrimId;
    return data;
  }
}
