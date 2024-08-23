class GetExteriorColorFilterModel {
  List<GetExteriorColorFilterResult>? result;
  String? message;
  String? status;

  GetExteriorColorFilterModel({this.result, this.message, this.status});

  GetExteriorColorFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetExteriorColorFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetExteriorColorFilterResult.fromJson(v));
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

class GetExteriorColorFilterResult {
  String? id;
  String? name;
  String? code;

  GetExteriorColorFilterResult({this.id, this.name, this.code});

  GetExteriorColorFilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
