class GetElectronicsConditionFilterModel {
  List<GetElectronicsConditionFilterResult>? result;
  String? message;
  String? status;

  GetElectronicsConditionFilterModel({this.result, this.message, this.status});

  GetElectronicsConditionFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetElectronicsConditionFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetElectronicsConditionFilterResult.fromJson(v));
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

class GetElectronicsConditionFilterResult {
  String? conditionId;
  String? conditionName;
  String? dateTime;

  GetElectronicsConditionFilterResult({this.conditionId, this.conditionName, this.dateTime});

  GetElectronicsConditionFilterResult.fromJson(Map<String, dynamic> json) {
    conditionId = json['condition_id'];
    conditionName = json['condition_name'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition_id'] = this.conditionId;
    data['condition_name'] = this.conditionName;
    data['date_time'] = this.dateTime;
    return data;
  }
}
