class GetOperatorsModel {
  List<GetOperatorsResult>? result;
  String? message;
  String? status;

  GetOperatorsModel({this.result, this.message, this.status});

  GetOperatorsModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetOperatorsResult>[];
      json['result'].forEach((v) {
        result!.add(new GetOperatorsResult.fromJson(v));
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

class GetOperatorsResult {
  String? operatorsId;
  String? operatorsName;

  GetOperatorsResult({this.operatorsId, this.operatorsName});

  GetOperatorsResult.fromJson(Map<String, dynamic> json) {
    operatorsId = json['operators_id'];
    operatorsName = json['operators_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operators_id'] = this.operatorsId;
    data['operators_name'] = this.operatorsName;
    return data;
  }
}
