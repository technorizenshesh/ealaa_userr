import 'get_ads_with_category_home_model.dart';

class GetAdsWithCategorySubCategoryModel {
  List<PostListDetails>? result;
  String? message;
  String? status;

  GetAdsWithCategorySubCategoryModel({this.result, this.message, this.status});

  GetAdsWithCategorySubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <PostListDetails>[];
      json['result'].forEach((v) {
        result!.add(PostListDetails.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
}

