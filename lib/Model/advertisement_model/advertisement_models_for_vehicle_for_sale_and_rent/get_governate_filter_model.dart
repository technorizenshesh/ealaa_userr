class GetGovernorateFilterModel {
  List<GetGovernorateFilterResult>? result;
  String? message;
  String? status;

  GetGovernorateFilterModel({this.result, this.message, this.status});

  GetGovernorateFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetGovernorateFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetGovernorateFilterResult.fromJson(v));
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

class GetGovernorateFilterResult {
  String? id;
  String? name;
  String? dateTime;

  GetGovernorateFilterResult({this.id, this.name, this.dateTime});

  GetGovernorateFilterResult.fromJson(Map<String, dynamic> json) {
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
