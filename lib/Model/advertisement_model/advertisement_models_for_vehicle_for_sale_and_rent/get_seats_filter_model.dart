class GetSeatsFilterModel {
  List<GetSeatsFilterResult>? result;
  String? message;
  String? status;

  GetSeatsFilterModel({this.result, this.message, this.status});

  GetSeatsFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetSeatsFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetSeatsFilterResult.fromJson(v));
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

class GetSeatsFilterResult {
  String? id;
  String? name;
  String? dateTime;

  GetSeatsFilterResult({this.id, this.name, this.dateTime});

  GetSeatsFilterResult.fromJson(Map<String, dynamic> json) {
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
