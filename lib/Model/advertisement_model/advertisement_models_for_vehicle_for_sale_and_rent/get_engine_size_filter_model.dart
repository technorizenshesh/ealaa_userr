class GetEngineSizeFilterModel {
  List<GetEngineSizeFilterResult>? result;
  String? message;
  String? status;

  GetEngineSizeFilterModel({this.result, this.message, this.status});

  GetEngineSizeFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetEngineSizeFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetEngineSizeFilterResult.fromJson(v));
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

class GetEngineSizeFilterResult {
  String? id;
  String? name;
  String? dateTime;

  GetEngineSizeFilterResult({this.id, this.name, this.dateTime});

  GetEngineSizeFilterResult.fromJson(Map<String, dynamic> json) {
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
