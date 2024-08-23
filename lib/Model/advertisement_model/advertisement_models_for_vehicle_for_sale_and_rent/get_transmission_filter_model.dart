class GetTransmissionFilterModel {
  List<GetTransmissionFilterResult>? result;
  String? message;
  String? status;

  GetTransmissionFilterModel({this.result, this.message, this.status});

  GetTransmissionFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetTransmissionFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetTransmissionFilterResult.fromJson(v));
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

class GetTransmissionFilterResult {
  String? id;
  String? name;
  String? dateTime;

  GetTransmissionFilterResult({this.id, this.name, this.dateTime});

  GetTransmissionFilterResult.fromJson(Map<String, dynamic> json) {
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
