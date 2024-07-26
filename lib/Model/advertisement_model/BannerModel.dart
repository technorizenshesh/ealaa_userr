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

}

class AdsBannerResult {
  String? id;
  String? type;
  String? image;
  String? urlLink;
  String? dateTime;

  AdsBannerResult({this.id, this.type, this.image,this.urlLink, this.dateTime});

  AdsBannerResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    dateTime = json['date_time'];
    urlLink = json['url_link'];
  }
}
