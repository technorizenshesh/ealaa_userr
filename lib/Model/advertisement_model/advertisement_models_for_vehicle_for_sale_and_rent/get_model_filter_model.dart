class GetModelFilterModel {
  List<GetModelFilterResult>? result;
  String? message;
  String? status;

  GetModelFilterModel({this.result, this.message, this.status});

  GetModelFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetModelFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetModelFilterResult.fromJson(v));
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

class GetModelFilterResult {
  String? id;
  String? name;
  String? image;
  String? dateTime;
  String? type;
  String? makerId;

  GetModelFilterResult(
      {this.id, this.name, this.image, this.dateTime, this.type, this.makerId});

  GetModelFilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    dateTime = json['date_time'];
    type = json['type'];
    makerId = json['maker_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['date_time'] = this.dateTime;
    data['type'] = this.type;
    data['maker_id'] = this.makerId;
    return data;
  }
}
