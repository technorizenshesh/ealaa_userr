class GetModelTrimFilterModel {
  List<GetModelTrimFilterResult>? result;
  String? message;
  String? status;

  GetModelTrimFilterModel({this.result, this.message, this.status});

  GetModelTrimFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetModelTrimFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetModelTrimFilterResult.fromJson(v));
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

class GetModelTrimFilterResult {
  String? id;
  String? name;
  String? image;
  String? dateTime;
  String? modelId;

  GetModelTrimFilterResult({this.id, this.name, this.image, this.dateTime, this.modelId});

  GetModelTrimFilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    dateTime = json['date_time'];
    modelId = json['model_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['date_time'] = this.dateTime;
    data['model_id'] = this.modelId;
    return data;
  }
}
