class GetPlateFilterModel {
  List<GetPlateFilterResult>? result;
  String? message;
  String? status;

  GetPlateFilterModel({this.result, this.message, this.status});

  GetPlateFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetPlateFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetPlateFilterResult.fromJson(v));
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

class GetPlateFilterResult {
  String? id;
  String? name;

  GetPlateFilterResult({this.id, this.name});

  GetPlateFilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
