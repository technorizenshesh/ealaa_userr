class GetOriginFilterModel {
  List<GetOriginFilterResult>? result;
  String? message;
  String? status;

  GetOriginFilterModel({this.result, this.message, this.status});

  GetOriginFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetOriginFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetOriginFilterResult.fromJson(v));
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

class GetOriginFilterResult {
  String? id;
  String? name;
  String? dateTime;

  GetOriginFilterResult({this.id, this.name, this.dateTime});

  GetOriginFilterResult.fromJson(Map<String, dynamic> json) {
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
