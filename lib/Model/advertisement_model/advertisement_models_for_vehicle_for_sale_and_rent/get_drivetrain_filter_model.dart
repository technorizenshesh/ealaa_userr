class GetDrivetrainFilterModel {
  List<GetDrivetrainFilterResult>? result;
  String? message;
  String? status;

  GetDrivetrainFilterModel({this.result, this.message, this.status});

  GetDrivetrainFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetDrivetrainFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetDrivetrainFilterResult.fromJson(v));
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

class GetDrivetrainFilterResult {
  String? id;
  String? name;
  String? dateTime;

  GetDrivetrainFilterResult({this.id, this.name, this.dateTime});

  GetDrivetrainFilterResult.fromJson(Map<String, dynamic> json) {
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
