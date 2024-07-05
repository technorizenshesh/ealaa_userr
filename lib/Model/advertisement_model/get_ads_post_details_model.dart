import 'get_ads_with_category_home_model.dart';

class GetAdsPostDetailsModel {
  PostListDetails? result;
  String? message;
  String? status;

  GetAdsPostDetailsModel({this.result, this.message, this.status});

  GetAdsPostDetailsModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? PostListDetails.fromJson(json['result']) : null;
    message = json['message'];
    status = json['status'];
  }
}

