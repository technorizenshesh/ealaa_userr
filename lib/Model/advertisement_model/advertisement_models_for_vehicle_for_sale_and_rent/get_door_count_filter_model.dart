class GetDoorCountFilterModel {
  List<GetDoorCountFilterResult>? result;
  String? message;
  String? status;

  GetDoorCountFilterModel({this.result, this.message, this.status});

  GetDoorCountFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetDoorCountFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetDoorCountFilterResult.fromJson(v));
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

class GetDoorCountFilterResult {
  String? id;
  String? name;
  String? dateTime;

  GetDoorCountFilterResult({this.id, this.name, this.dateTime});

  GetDoorCountFilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date_time'] = this.dateTime;
    return data;
  }
}
