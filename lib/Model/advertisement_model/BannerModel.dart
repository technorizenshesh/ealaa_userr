class AdsBannerModel {
  List<AdsBannerResult>? result;
  String? message;
  String? status;

  AdsBannerModel({this.result, this.message, this.status});

  AdsBannerModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <AdsBannerResult>[];
      json['result'].forEach((v) {
        result!.add(new AdsBannerResult.fromJson(v));
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

class AdsBannerResult {
  String? id;
  String? type;
  String? image;
  String? dateTime;

  AdsBannerResult({this.id, this.type, this.image, this.dateTime});

  AdsBannerResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['image'] = this.image;
    data['date_time'] = this.dateTime;
    return data;
  }
}
