class GetVehiclesPartsMakeFilterModel {
  List<GetVehiclesPartsMakeFilterResult>? result;
  String? message;
  String? status;

  GetVehiclesPartsMakeFilterModel({this.result, this.message, this.status});

  GetVehiclesPartsMakeFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetVehiclesPartsMakeFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetVehiclesPartsMakeFilterResult.fromJson(v));
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

class GetVehiclesPartsMakeFilterResult {
  String? id;
  String? name;
  String? dateTime;
  String? image;
  String? type;
  String? subCategoryId;

  GetVehiclesPartsMakeFilterResult(
      {this.id,
        this.name,
        this.dateTime,
        this.image,
        this.type,
        this.subCategoryId});

  GetVehiclesPartsMakeFilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateTime = json['date_time'];
    image = json['image'];
    type = json['type'];
    subCategoryId = json['sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date_time'] = this.dateTime;
    data['image'] = this.image;
    data['type'] = this.type;
    data['sub_category_id'] = this.subCategoryId;
    return data;
  }
}
