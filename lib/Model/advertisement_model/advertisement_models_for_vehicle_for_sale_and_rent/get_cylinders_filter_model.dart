class GetCylindersFilterModel {
  List<GetCylindersFilterResult>? result;
  String? message;
  String? status;

  GetCylindersFilterModel({this.result, this.message, this.status});

  GetCylindersFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetCylindersFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetCylindersFilterResult.fromJson(v));
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

class GetCylindersFilterResult {
  String? id;
  String? name;

  GetCylindersFilterResult({this.id, this.name});

  GetCylindersFilterResult.fromJson(Map<String, dynamic> json) {
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
