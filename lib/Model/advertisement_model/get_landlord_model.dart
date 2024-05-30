class GetLandLordModel {
  List<GetLandLordResult>? result;
  String? message;
  String? status;

  GetLandLordModel({this.result, this.message, this.status});

  GetLandLordModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetLandLordResult>[];
      json['result'].forEach((v) {
        result!.add(GetLandLordResult.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class GetLandLordResult {
  String? id;
  String? name;
  String? dateTime;

  GetLandLordResult({this.id, this.name, this.dateTime});

  GetLandLordResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['date_time'] = dateTime;
    return data;
  }
}
