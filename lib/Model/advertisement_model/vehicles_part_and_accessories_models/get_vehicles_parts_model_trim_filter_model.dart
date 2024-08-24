class GetVehiclesPartsModelTrimFilterModel {
  List<GetVehiclesPartsModelTrimFilterResult>? result;
  String? message;
  String? status;

  GetVehiclesPartsModelTrimFilterModel(
      {this.result, this.message, this.status});

  GetVehiclesPartsModelTrimFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetVehiclesPartsModelTrimFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetVehiclesPartsModelTrimFilterResult.fromJson(v));
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

class GetVehiclesPartsModelTrimFilterResult {
  String? id;
  String? name;
  String? image;
  String? dateTime;
  String? modelId;

  GetVehiclesPartsModelTrimFilterResult({this.id, this.name, this.image, this.dateTime, this.modelId});

  GetVehiclesPartsModelTrimFilterResult.fromJson(Map<String, dynamic> json) {
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
