class GetNumberTypeModel {
  List<GetNumberTypeResult>? result;
  String? message;
  String? status;

  GetNumberTypeModel({this.result, this.message, this.status});

  GetNumberTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetNumberTypeResult>[];
      json['result'].forEach((v) {
        result!.add(new GetNumberTypeResult.fromJson(v));
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

class GetNumberTypeResult {
  String? id;
  String? vehiclesNumberTypeName;

  GetNumberTypeResult({this.id, this.vehiclesNumberTypeName});

  GetNumberTypeResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehiclesNumberTypeName = json['vehicles_number_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicles_number_type_name'] = this.vehiclesNumberTypeName;
    return data;
  }
}
