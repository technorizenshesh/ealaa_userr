/*
class AllCategoryPostModel {
  List<AllCategoryPostResult>? result;
  String? message;
  String? status;

  AllCategoryPostModel({this.result, this.message, this.status});

  AllCategoryPostModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <AllCategoryPostResult>[];
      json['result'].forEach((v) {
        result!.add(new AllCategoryPostResult.fromJson(v));
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

class AllCategoryPostResult {
  List<PostListDetails>? postListDetails;
  String? name;
  int? count;

  AllCategoryPostResult({this.postListDetails, this.name, this.count});

  AllCategoryPostResult.fromJson(Map<String, dynamic> json) {
    if (json['post_list_details'] != null) {
      postListDetails = <PostListDetails>[];
      json['post_list_details'].forEach((v) {
        postListDetails!.add(new PostListDetails.fromJson(v));
      });
    }
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postListDetails != null) {
      data['post_list_details'] =
          this.postListDetails!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class PostListDetails {
  String? adsId;
  String? adsType;
  String? adsCategoryId;
  String? adsSubCategoryId;
  String? adsDetailsId;
  String? adsCreatedAt;
  String? adsUpdatedAt;
  Null? adsDeletedAt;
  String? adsAdminStatus;
  String? adsImage;
  String? adsName;
  String? adsPrice;
  AdsDetails? adsDetails;

  PostListDetails(
      {this.adsId,
        this.adsType,
        this.adsCategoryId,
        this.adsSubCategoryId,
        this.adsDetailsId,
        this.adsCreatedAt,
        this.adsUpdatedAt,
        this.adsDeletedAt,
        this.adsAdminStatus,
        this.adsImage,
        this.adsName,
        this.adsPrice,
        this.adsDetails});

  PostListDetails.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
    adsType = json['ads_type'];
    adsCategoryId = json['ads_category_id'];
    adsSubCategoryId = json['ads_sub_category_id'];
    adsDetailsId = json['ads_details_id'];
    adsCreatedAt = json['ads_created_at'];
    adsUpdatedAt = json['ads_updated_at'];
    adsDeletedAt = json['ads_deleted_at'];
    adsAdminStatus = json['ads_admin_status'];
    adsImage = json['ads_image'];
    adsName = json['ads_name'];
    adsPrice = json['ads_price'];
    adsDetails = json['ads_details'] != null
        ? new AdsDetails.fromJson(json['ads_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ads_id'] = this.adsId;
    data['ads_type'] = this.adsType;
    data['ads_category_id'] = this.adsCategoryId;
    data['ads_sub_category_id'] = this.adsSubCategoryId;
    data['ads_details_id'] = this.adsDetailsId;
    data['ads_created_at'] = this.adsCreatedAt;
    data['ads_updated_at'] = this.adsUpdatedAt;
    data['ads_deleted_at'] = this.adsDeletedAt;
    data['ads_admin_status'] = this.adsAdminStatus;
    data['ads_image'] = this.adsImage;
    data['ads_name'] = this.adsName;
    data['ads_price'] = this.adsPrice;
    if (this.adsDetails != null) {
      data['ads_details'] = this.adsDetails!.toJson();
    }
    return data;
  }
}

class AdsDetails {
  String? vehicleAdsDetailId;
  String? vehicleAdsDetailUserId;
  String? vehicleAdsDetailMakerId;
  String? vehicleAdsDetailModelId;
  String? vehicleAdsDetailModelTrimId;
  String? vehicleAdsDetailYear;
  String? vehicleAdsDetailCondition;
  String? vehicleAdsDetailEngineSize;
  String? vehicleAdsDetailDoors;
  String? vehicleAdsDetailExteriorColor;
  String? vehicleAdsDetailInteriorColor;
  String? vehicleAdsDetailCylinders;
  String? vehicleAdsDetailFuel;
  String? vehicleAdsDetailTransmission;
  String? vehicleAdsDetailDriveTrain;
  String? vehicleAdsDetailSeats;
  String? vehicleAdsDetailPlate;
  String? vehicleAdsDetailOrigin;
  String? vehicleAdsDetailGovernate;
  String? vehicleAdsDetailState;
  String? vehicleAdsUploadImage;
  String? vehicleAdsAdditionalDetailPrice;
  String? vehicleAdsAdditionalDetailDistanceTravelled;
  String? vehicleAdsAdditionalDetailPhone;
  String? vehicleAdsAdditionalDetailDescription;
  String? vehicleAdsDetailAdsPostId;
  String? adsImage;
  String? adsName;
  String? adsPrice;
  String? realStateAdsDetailId;
  String? realStateAdsDetailUserId;
  String? realStateAdsDetailUseId;
  String? realStateAdsDetailWallId;
  String? realStateAdsDetailLandtypeId;
  String? realStateAdsDetailPositionId;
  String? realStateAdsDetailParkingId;
  String? realStateAdsDetailStateId;
  String? realStateAdsDetailGovernateId;
  String? realStateAdsUploadImage;
  String? realStateAdsAdditionalDetailPrice;
  String? realStateAdsAdditionalDetailLandArea;
  String? realStateAdsAdditionalDetailPhone;
  String? realStateAdsAdditionalDetailDescription;
  String? realStateAdsDetailCityId;
  String? realStateAdsDetailAdsPostId;
  String? animalsAdsId;
  String? animalsAdsUserId;
  String? animalsAdsType;
  String? animalsAdsGender;
  String? animalsAdsAge;
  String? animalsAdsBreedOrigin;
  String? animalsAdsGovernorate;
  String? animalsAdsState;
  String? animalsAdsCity;
  String? animalsAdsImage;
  String? animalsAdsPostId;
  String? animalsAdsPrice;
  String? animalsAdsDistanceTitle;
  String? animalsAdsPhone;
  String? animalsAdsDescription;
  String? phoneNumberAdsId;
  String? phoneNumberAdsUserId;
  String? phoneNumberAdsOperators;
  String? phoneNumberAdsGovernorate;
  String? phoneNumberAdsState;
  String? phoneNumberAdsCity;
  String? phoneNumberAdsDescription;
  String? phoneNumberAdsImage;
  String? phoneNumberAdsPostId;
  String? phoneNumberAdsPhone;
  String? phoneNumberAdsPrice;

  AdsDetails(
      {this.vehicleAdsDetailId,
        this.vehicleAdsDetailUserId,
        this.vehicleAdsDetailMakerId,
        this.vehicleAdsDetailModelId,
        this.vehicleAdsDetailModelTrimId,
        this.vehicleAdsDetailYear,
        this.vehicleAdsDetailCondition,
        this.vehicleAdsDetailEngineSize,
        this.vehicleAdsDetailDoors,
        this.vehicleAdsDetailExteriorColor,
        this.vehicleAdsDetailInteriorColor,
        this.vehicleAdsDetailCylinders,
        this.vehicleAdsDetailFuel,
        this.vehicleAdsDetailTransmission,
        this.vehicleAdsDetailDriveTrain,
        this.vehicleAdsDetailSeats,
        this.vehicleAdsDetailPlate,
        this.vehicleAdsDetailOrigin,
        this.vehicleAdsDetailGovernate,
        this.vehicleAdsDetailState,
        this.vehicleAdsUploadImage,
        this.vehicleAdsAdditionalDetailPrice,
        this.vehicleAdsAdditionalDetailDistanceTravelled,
        this.vehicleAdsAdditionalDetailPhone,
        this.vehicleAdsAdditionalDetailDescription,
        this.vehicleAdsDetailAdsPostId,
        this.adsImage,
        this.adsName,
        this.adsPrice,
        this.realStateAdsDetailId,
        this.realStateAdsDetailUserId,
        this.realStateAdsDetailUseId,
        this.realStateAdsDetailWallId,
        this.realStateAdsDetailLandtypeId,
        this.realStateAdsDetailPositionId,
        this.realStateAdsDetailParkingId,
        this.realStateAdsDetailStateId,
        this.realStateAdsDetailGovernateId,
        this.realStateAdsUploadImage,
        this.realStateAdsAdditionalDetailPrice,
        this.realStateAdsAdditionalDetailLandArea,
        this.realStateAdsAdditionalDetailPhone,
        this.realStateAdsAdditionalDetailDescription,
        this.realStateAdsDetailCityId,
        this.realStateAdsDetailAdsPostId,
        this.animalsAdsId,
        this.animalsAdsUserId,
        this.animalsAdsType,
        this.animalsAdsGender,
        this.animalsAdsAge,
        this.animalsAdsBreedOrigin,
        this.animalsAdsGovernorate,
        this.animalsAdsState,
        this.animalsAdsCity,
        this.animalsAdsImage,
        this.animalsAdsPostId,
        this.animalsAdsPrice,
        this.animalsAdsDistanceTitle,
        this.animalsAdsPhone,
        this.animalsAdsDescription,
        this.phoneNumberAdsId,
        this.phoneNumberAdsUserId,
        this.phoneNumberAdsOperators,
        this.phoneNumberAdsGovernorate,
        this.phoneNumberAdsState,
        this.phoneNumberAdsCity,
        this.phoneNumberAdsDescription,
        this.phoneNumberAdsImage,
        this.phoneNumberAdsPostId,
        this.phoneNumberAdsPhone,
        this.phoneNumberAdsPrice});

  AdsDetails.fromJson(Map<String, dynamic> json) {
    vehicleAdsDetailId = json['vehicle_ads_detail_id'];
    vehicleAdsDetailUserId = json['vehicle_ads_detail_user_id'];
    vehicleAdsDetailMakerId = json['vehicle_ads_detail_maker_id'];
    vehicleAdsDetailModelId = json['vehicle_ads_detail_model_id'];
    vehicleAdsDetailModelTrimId = json['vehicle_ads_detail_model_trim_id'];
    vehicleAdsDetailYear = json['vehicle_ads_detail_year'];
    vehicleAdsDetailCondition = json['vehicle_ads_detail_condition'];
    vehicleAdsDetailEngineSize = json['vehicle_ads_detail_engine_size'];
    vehicleAdsDetailDoors = json['vehicle_ads_detail_doors'];
    vehicleAdsDetailExteriorColor = json['vehicle_ads_detail_exterior_color'];
    vehicleAdsDetailInteriorColor = json['vehicle_ads_detail_interior_color'];
    vehicleAdsDetailCylinders = json['vehicle_ads_detail_cylinders'];
    vehicleAdsDetailFuel = json['vehicle_ads_detail_fuel'];
    vehicleAdsDetailTransmission = json['vehicle_ads_detail_transmission'];
    vehicleAdsDetailDriveTrain = json['vehicle_ads_detail_drive_train'];
    vehicleAdsDetailSeats = json['vehicle_ads_detail_seats'];
    vehicleAdsDetailPlate = json['vehicle_ads_detail_plate'];
    vehicleAdsDetailOrigin = json['vehicle_ads_detail_origin'];
    vehicleAdsDetailGovernate = json['vehicle_ads_detail_governate'];
    vehicleAdsDetailState = json['vehicle_ads_detail_state'];
    vehicleAdsUploadImage = json['vehicle_ads_upload_image'];
    vehicleAdsAdditionalDetailPrice =
    json['vehicle_ads_additional_detail_price'];
    vehicleAdsAdditionalDetailDistanceTravelled =
    json['vehicle_ads_additional_detail_distance_travelled'];
    vehicleAdsAdditionalDetailPhone =
    json['vehicle_ads_additional_detail_phone'];
    vehicleAdsAdditionalDetailDescription =
    json['vehicle_ads_additional_detail_description'];
    vehicleAdsDetailAdsPostId = json['vehicle_ads_detail_ads_post_id'];
    adsImage = json['ads_image'];
    adsName = json['ads_name'];
    adsPrice = json['ads_price'];
    realStateAdsDetailId = json['real_state_ads_detail_id'];
    realStateAdsDetailUserId = json['real_state_ads_detail_user_id'];
    realStateAdsDetailUseId = json['real_state_ads_detail_use_id'];
    realStateAdsDetailWallId = json['real_state_ads_detail_wall_id'];
    realStateAdsDetailLandtypeId = json['real_state_ads_detail_landtype_id'];
    realStateAdsDetailPositionId = json['real_state_ads_detail_position_id'];
    realStateAdsDetailParkingId = json['real_state_ads_detail_parking_id'];
    realStateAdsDetailStateId = json['real_state_ads_detail_state_id'];
    realStateAdsDetailGovernateId = json['real_state_ads_detail_governate_id'];
    realStateAdsUploadImage = json['real_state_ads_upload_image'];
    realStateAdsAdditionalDetailPrice =
    json['real_state_ads_additional_detail_price'];
    realStateAdsAdditionalDetailLandArea =
    json['real_state_ads_additional_detail_land_area'];
    realStateAdsAdditionalDetailPhone =
    json['real_state_ads_additional_detail_phone'];
    realStateAdsAdditionalDetailDescription =
    json['real_state_ads_additional_detail_description'];
    realStateAdsDetailCityId = json['real_state_ads_detail_city_id'];
    realStateAdsDetailAdsPostId = json['real_state_ads_detail_ads_post_id'];
    animalsAdsId = json['animals_ads_id'];
    animalsAdsUserId = json['animals_ads_user_id'];
    animalsAdsType = json['animals_ads_type'];
    animalsAdsGender = json['animals_ads_gender'];
    animalsAdsAge = json['animals_ads_age'];
    animalsAdsBreedOrigin = json['animals_ads_breed_origin'];
    animalsAdsGovernorate = json['animals_ads_governorate'];
    animalsAdsState = json['animals_ads_state'];
    animalsAdsCity = json['animals_ads_city'];
    animalsAdsImage = json['animals_ads_image'];
    animalsAdsPostId = json['animals_ads_post_id'];
    animalsAdsPrice = json['animals_ads_price'];
    animalsAdsDistanceTitle = json['animals_ads_distance_title'];
    animalsAdsPhone = json['animals_ads_phone'];
    animalsAdsDescription = json['animals_ads_description'];
    phoneNumberAdsId = json['phone_number_ads_id'];
    phoneNumberAdsUserId = json['phone_number_ads_user_id'];
    phoneNumberAdsOperators = json['phone_number_ads_operators'];
    phoneNumberAdsGovernorate = json['phone_number_ads_governorate'];
    phoneNumberAdsState = json['phone_number_ads_state'];
    phoneNumberAdsCity = json['phone_number_ads_city'];
    phoneNumberAdsDescription = json['phone_number_ads_description'];
    phoneNumberAdsImage = json['phone_number_ads_image'];
    phoneNumberAdsPostId = json['phone_number_ads_post_id'];
    phoneNumberAdsPhone = json['phone_number_ads_phone'];
    phoneNumberAdsPrice = json['phone_number_ads_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_ads_detail_id'] = this.vehicleAdsDetailId;
    data['vehicle_ads_detail_user_id'] = this.vehicleAdsDetailUserId;
    data['vehicle_ads_detail_maker_id'] = this.vehicleAdsDetailMakerId;
    data['vehicle_ads_detail_model_id'] = this.vehicleAdsDetailModelId;
    data['vehicle_ads_detail_model_trim_id'] = this.vehicleAdsDetailModelTrimId;
    data['vehicle_ads_detail_year'] = this.vehicleAdsDetailYear;
    data['vehicle_ads_detail_condition'] = this.vehicleAdsDetailCondition;
    data['vehicle_ads_detail_engine_size'] = this.vehicleAdsDetailEngineSize;
    data['vehicle_ads_detail_doors'] = this.vehicleAdsDetailDoors;
    data['vehicle_ads_detail_exterior_color'] =
        this.vehicleAdsDetailExteriorColor;
    data['vehicle_ads_detail_interior_color'] =
        this.vehicleAdsDetailInteriorColor;
    data['vehicle_ads_detail_cylinders'] = this.vehicleAdsDetailCylinders;
    data['vehicle_ads_detail_fuel'] = this.vehicleAdsDetailFuel;
    data['vehicle_ads_detail_transmission'] = this.vehicleAdsDetailTransmission;
    data['vehicle_ads_detail_drive_train'] = this.vehicleAdsDetailDriveTrain;
    data['vehicle_ads_detail_seats'] = this.vehicleAdsDetailSeats;
    data['vehicle_ads_detail_plate'] = this.vehicleAdsDetailPlate;
    data['vehicle_ads_detail_origin'] = this.vehicleAdsDetailOrigin;
    data['vehicle_ads_detail_governate'] = this.vehicleAdsDetailGovernate;
    data['vehicle_ads_detail_state'] = this.vehicleAdsDetailState;
    data['vehicle_ads_upload_image'] = this.vehicleAdsUploadImage;
    data['vehicle_ads_additional_detail_price'] =
        this.vehicleAdsAdditionalDetailPrice;
    data['vehicle_ads_additional_detail_distance_travelled'] =
        this.vehicleAdsAdditionalDetailDistanceTravelled;
    data['vehicle_ads_additional_detail_phone'] =
        this.vehicleAdsAdditionalDetailPhone;
    data['vehicle_ads_additional_detail_description'] =
        this.vehicleAdsAdditionalDetailDescription;
    data['vehicle_ads_detail_ads_post_id'] = this.vehicleAdsDetailAdsPostId;
    data['ads_image'] = this.adsImage;
    data['ads_name'] = this.adsName;
    data['ads_price'] = this.adsPrice;
    data['real_state_ads_detail_id'] = this.realStateAdsDetailId;
    data['real_state_ads_detail_user_id'] = this.realStateAdsDetailUserId;
    data['real_state_ads_detail_use_id'] = this.realStateAdsDetailUseId;
    data['real_state_ads_detail_wall_id'] = this.realStateAdsDetailWallId;
    data['real_state_ads_detail_landtype_id'] =
        this.realStateAdsDetailLandtypeId;
    data['real_state_ads_detail_position_id'] =
        this.realStateAdsDetailPositionId;
    data['real_state_ads_detail_parking_id'] = this.realStateAdsDetailParkingId;
    data['real_state_ads_detail_state_id'] = this.realStateAdsDetailStateId;
    data['real_state_ads_detail_governate_id'] =
        this.realStateAdsDetailGovernateId;
    data['real_state_ads_upload_image'] = this.realStateAdsUploadImage;
    data['real_state_ads_additional_detail_price'] =
        this.realStateAdsAdditionalDetailPrice;
    data['real_state_ads_additional_detail_land_area'] =
        this.realStateAdsAdditionalDetailLandArea;
    data['real_state_ads_additional_detail_phone'] =
        this.realStateAdsAdditionalDetailPhone;
    data['real_state_ads_additional_detail_description'] =
        this.realStateAdsAdditionalDetailDescription;
    data['real_state_ads_detail_city_id'] = this.realStateAdsDetailCityId;
    data['real_state_ads_detail_ads_post_id'] =
        this.realStateAdsDetailAdsPostId;
    data['animals_ads_id'] = this.animalsAdsId;
    data['animals_ads_user_id'] = this.animalsAdsUserId;
    data['animals_ads_type'] = this.animalsAdsType;
    data['animals_ads_gender'] = this.animalsAdsGender;
    data['animals_ads_age'] = this.animalsAdsAge;
    data['animals_ads_breed_origin'] = this.animalsAdsBreedOrigin;
    data['animals_ads_governorate'] = this.animalsAdsGovernorate;
    data['animals_ads_state'] = this.animalsAdsState;
    data['animals_ads_city'] = this.animalsAdsCity;
    data['animals_ads_image'] = this.animalsAdsImage;
    data['animals_ads_post_id'] = this.animalsAdsPostId;
    data['animals_ads_price'] = this.animalsAdsPrice;
    data['animals_ads_distance_title'] = this.animalsAdsDistanceTitle;
    data['animals_ads_phone'] = this.animalsAdsPhone;
    data['animals_ads_description'] = this.animalsAdsDescription;
    data['phone_number_ads_id'] = this.phoneNumberAdsId;
    data['phone_number_ads_user_id'] = this.phoneNumberAdsUserId;
    data['phone_number_ads_operators'] = this.phoneNumberAdsOperators;
    data['phone_number_ads_governorate'] = this.phoneNumberAdsGovernorate;
    data['phone_number_ads_state'] = this.phoneNumberAdsState;
    data['phone_number_ads_city'] = this.phoneNumberAdsCity;
    data['phone_number_ads_description'] = this.phoneNumberAdsDescription;
    data['phone_number_ads_image'] = this.phoneNumberAdsImage;
    data['phone_number_ads_post_id'] = this.phoneNumberAdsPostId;
    data['phone_number_ads_phone'] = this.phoneNumberAdsPhone;
    data['phone_number_ads_price'] = this.phoneNumberAdsPrice;
    return data;
  }
}
*/
