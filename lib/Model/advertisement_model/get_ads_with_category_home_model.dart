class GetAdsWithCategoryHomeModel {
  List<GetAdsWithCategoryHomeResult>? result;
  String? message;
  String? status;

  GetAdsWithCategoryHomeModel({this.result, this.message, this.status});

  GetAdsWithCategoryHomeModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetAdsWithCategoryHomeResult>[];
      json['result'].forEach((v) {
        result!.add(GetAdsWithCategoryHomeResult.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
}

class GetAdsWithCategoryHomeResult {
  String? id;
  String? name;
  String? image;
  String? dateTime;
  String? type;
  List<PostListDetails>? postListDetails;
  int? totalCount;

  GetAdsWithCategoryHomeResult(
      {this.id,
        this.name,
        this.image,
        this.dateTime,
        this.type,
        this.postListDetails,
        this.totalCount});

  GetAdsWithCategoryHomeResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    dateTime = json['date_time'];
    type = json['type'];
    if (json['post_list_details'] != null) {
      postListDetails = <PostListDetails>[];
      json['post_list_details'].forEach((v) {
        postListDetails!.add(PostListDetails.fromJson(v));
      });
    }
    totalCount = json['total_count'];
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
  String? adsDeletedAt;
  String? adsAdminStatus;
  String? postFav;
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
  String? vehiclePartAdsId;
  String? vehiclePartPartId;
  String? vehiclePartSubPartId;
  String? vehiclePartMakerId;
  String? vehiclePartModelId;
  String? vehiclePartModelTrimId;
  String? vehiclePartModelYearId;
  String? vehiclePartEngineSizeId;
  String? vehiclePartImage;
  String? vehiclePartPrice;
  String? vehiclePartQuantity;
  String? vehiclePartPartNumber;
  String? vehiclePartEnglishTitle;
  String? vehiclePartArabicTitle;
  String? vehiclePartPhone;
  String? vehiclePartDescription;
  String? vehiclePartAdsPostId;
  String? vehicleGovernorateId;
  String? vehicleStateId;
  String? vehicleCityId;
  String? vehicleNumberId;
  String? vehicleNumberLetterId;
  String? vehicleNumberPlateTypeId;
  String? vehicleNumberGovernorateId;
  String? vehicleNumberStateId;
  String? vehicleNumberCityId;
  String? vehicleNumberPrice;
  String? vehicleNumberImage;
  String? vehicleNumberPhone;
  String? vehicleNumberDescription;
  String? vehicleNumberAdsPostId;
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
  String? useName;
  String? wallName;
  String? landtypeName;
  String? parkingName;
  String? stateName;
  String? governorateName;
  String? cityName;
  String? electronicsAdsId;
  String? electronicsAdsBrand;
  String? electronicsAdsBrandModelId;
  String? electronicsAdsBrandModelName;
  String? electronicsAdsStorage;
  String? electronicsAdsCondition;
  String? electronicsAdsWarranty;
  String? electronicsAdsGovernorate;
  String? electronicsAdsState;
  String? electronicsAdsCity;
  String? electronicsAdsDescription;
  String? electronicsAdsPostId;
  String? electronicsAdsPrice;
  String? electronicsAdsImage;
  String? electronicsAdsUserId;
  String? phoneNumberAdsId;
  String? phoneNumberAdsUserId;
  String? phoneNumberAdsOperators;
  String? numberType;
  String? phoneNumberAdsGovernorate;
  String? phoneNumberAdsState;
  String? phoneNumberAdsCity;
  String? phoneNumberAdsDescription;
  String? phoneNumberAdsImage;
  String? phoneNumberAdsPostId;
  String? phoneNumberAdsPhone;
  String? phoneNumberAdsPrice;
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
  UsersDetails?  usersDetails;
  String? partName;
  String? subPartName;
  String? makername;
  String? modelname;
  String? modelTrimName;
  String? yearName;
  String? engineValue;
  String? categoryName;
  String? subCategoryName;
  String? typeName;
  String? ageName;
  String? genderName;
  String? breedName;
  String? brandName;
  String? storageName;
  String? conditionName;
  String? warrantyName;
  String? operatorsName;
  String? letterNameEnglish;
  String? plateTypeName;
  String? uploadVehiclesNumbers;
  String? letterType;


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
        this.postFav,
        this.vehicleAdsDetailId,
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
        this.vehiclePartAdsId,
        this.vehiclePartPartId,
        this.vehiclePartSubPartId,
        this.vehiclePartMakerId,
        this.vehiclePartModelId,
        this.vehiclePartModelTrimId,
        this.vehiclePartModelYearId,
        this.vehiclePartEngineSizeId,
        this.vehiclePartImage,
        this.vehiclePartPrice,
        this.vehiclePartQuantity,
        this.vehiclePartPartNumber,
        this.vehiclePartEnglishTitle,
        this.vehiclePartArabicTitle,
        this.vehiclePartPhone,
        this.vehiclePartDescription,
        this.vehiclePartAdsPostId,
        this.vehicleGovernorateId,
        this.vehicleStateId,
        this.vehicleCityId,
        this.vehicleNumberId,
        this.vehicleNumberLetterId,
        this.vehicleNumberPlateTypeId,
        this.vehicleNumberGovernorateId,
        this.vehicleNumberStateId,
        this.vehicleNumberCityId,
        this.vehicleNumberPrice,
        this.vehicleNumberImage,
        this.vehicleNumberPhone,
        this.vehicleNumberDescription,
        this.vehicleNumberAdsPostId,
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
        this.useName,
        this.wallName,
        this.landtypeName,
        this.parkingName,
        this.stateName,
        this.governorateName,
        this.cityName,
        this.electronicsAdsId,
        this.electronicsAdsBrand,
        this.electronicsAdsBrandModelId,
        this.electronicsAdsBrandModelName,
        this.electronicsAdsStorage,
        this.electronicsAdsCondition,
        this.electronicsAdsWarranty,
        this.electronicsAdsGovernorate,
        this.electronicsAdsState,
        this.electronicsAdsCity,
        this.electronicsAdsDescription,
        this.electronicsAdsPostId,
        this.electronicsAdsPrice,
        this.electronicsAdsImage,
        this.electronicsAdsUserId,
        this.phoneNumberAdsId,
        this.phoneNumberAdsUserId,
        this.phoneNumberAdsOperators,
        this.numberType,
        this.phoneNumberAdsGovernorate,
        this.phoneNumberAdsState,
        this.phoneNumberAdsCity,
        this.phoneNumberAdsDescription,
        this.phoneNumberAdsImage,
        this.phoneNumberAdsPostId,
        this.phoneNumberAdsPhone,
        this.phoneNumberAdsPrice,
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
        this.usersDetails,
        this.partName,
        this.subPartName,
        this.makername,
        this.modelname,
        this.modelTrimName,
        this.yearName,
        this.engineValue,
        this.categoryName,
        this.subCategoryName,
        this.typeName,
        this.ageName,
        this.genderName,
        this.breedName,
        this.brandName,
        this.storageName,
        this.conditionName,
        this.warrantyName,
        this.operatorsName,
        this.letterNameEnglish,
        this.plateTypeName,
        this.uploadVehiclesNumbers,
        this.letterType,
      });

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
    postFav = json['post_fav'];
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
    vehiclePartAdsId = json['vehicle_part_ads_id'];
    vehiclePartPartId = json['vehicle_part_part_id'];
    vehiclePartSubPartId = json['vehicle_part_sub_part_id'];
    vehiclePartMakerId = json['vehicle_part_maker_id'];
    vehiclePartModelId = json['vehicle_part_model_id'];
    vehiclePartModelTrimId = json['vehicle_part_model_trim_id'];
    vehiclePartModelYearId = json['vehicle_part_model_year_id'];
    vehiclePartEngineSizeId = json['vehicle_part_engine_size_id'];
    vehiclePartImage = json['vehicle_part_image'];
    vehiclePartPrice = json['vehicle_part_price'];
    vehiclePartQuantity = json['vehicle_part_quantity'];
    vehiclePartPartNumber = json['vehicle_part_part_number'];
    vehiclePartEnglishTitle = json['vehicle_part_english_title'];
    vehiclePartArabicTitle = json['vehicle_part_arabic_title'];
    vehiclePartPhone = json['vehicle_part_phone'];
    vehiclePartDescription = json['vehicle_part_description'];
    vehiclePartAdsPostId = json['vehicle_part_ads_post_id'];
    vehicleGovernorateId = json['vehicle_governorate_id'];
    vehicleStateId = json['vehicle_state_id'];
    vehicleCityId = json['vehicle_city_id'];
    vehicleNumberId = json['vehicle_number_id'];
    vehicleNumberLetterId = json['vehicle_number_letter_id'];
    vehicleNumberPlateTypeId = json['vehicle_number_plate_type_id'];
    vehicleNumberGovernorateId = json['vehicle_number_governorate_id'];
    vehicleNumberStateId = json['vehicle_number_state_id'];
    vehicleNumberCityId = json['vehicle_number_city_id'];
    vehicleNumberPrice = json['vehicle_number_price'];
    vehicleNumberImage = json['vehicle_number_image'];
    vehicleNumberPhone = json['vehicle_number_phone'];
    vehicleNumberDescription = json['vehicle_number_description'];
    vehicleNumberAdsPostId = json['vehicle_number_ads_post_id'];
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
    useName = json['use_name'];
    wallName = json['wall_name'];
    landtypeName = json['landtype_name'];
    parkingName = json['parking_name'];
    stateName = json['state_name'];
    governorateName = json['governorate_name'];
    cityName = json['city_name'];
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
    electronicsAdsId = json['electronics_ads_id'];
    electronicsAdsBrand = json['electronics_ads_brand'];
    electronicsAdsBrandModelId = json['electronics_ads_brand_model_id'];
    electronicsAdsBrandModelName = json['electronics_ads_brand_model_name'];
    electronicsAdsStorage = json['electronics_ads_storage'];
    electronicsAdsCondition = json['electronics_ads_condition'];
    electronicsAdsWarranty = json['electronics_ads_warranty'];
    electronicsAdsGovernorate = json['electronics_ads_governorate'];
    electronicsAdsState = json['electronics_ads_state'];
    electronicsAdsCity = json['electronics_ads_city'];
    electronicsAdsDescription = json['electronics_ads_description'];
    electronicsAdsPostId = json['electronics_ads_post_id'];
    electronicsAdsPrice = json['electronics_ads_price'];
    electronicsAdsImage = json['electronics_ads_image'];
    electronicsAdsUserId = json['electronics_ads_user_id'];
    phoneNumberAdsId = json['phone_number_ads_id'];
    phoneNumberAdsUserId = json['phone_number_ads_user_id'];
    phoneNumberAdsOperators = json['phone_number_ads_operators'];
    numberType = json['number_type'];
    phoneNumberAdsGovernorate = json['phone_number_ads_governorate'];
    phoneNumberAdsState = json['phone_number_ads_state'];
    phoneNumberAdsCity = json['phone_number_ads_city'];
    phoneNumberAdsDescription = json['phone_number_ads_description'];
    phoneNumberAdsImage = json['phone_number_ads_image'];
    phoneNumberAdsPostId = json['phone_number_ads_post_id'];
    phoneNumberAdsPhone = json['phone_number_ads_phone'];
    phoneNumberAdsPrice = json['phone_number_ads_price'];
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
    usersDetails = json['users_details'] != null && json['users_details'].isNotEmpty
        ? UsersDetails.fromJson(json['users_details'])
        : null;
    partName = json['part_name'];
    subPartName = json['sub_part_name'];
    makername = json['makername'];
    modelname = json['modelname'];
    modelTrimName = json['model_trim_name'];
    yearName = json['year_name'];
    engineValue = json['engine_value'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    typeName = json['type_name'];
    ageName = json['age_name'];
    genderName = json['gender_name'];
    breedName = json['breed_name'];
    brandName = json['brand_name'];
    storageName = json['storage_name'];
    conditionName = json['condition_name'];
    warrantyName = json['warranty_name'];
    operatorsName = json['operators_name'];
    letterNameEnglish = json['letter_name_english'];
    plateTypeName = json['plate_type_name'];
    uploadVehiclesNumbers = json['upload_vehicles_numbers'];
    letterType = json['letter_type'];
  }

}



class UsersDetails {
  String? id;
  String? fullName;
  String? userName;
  String? mobile;
  String? email;
  String? password;
  String? image;
  String? type;
  String? status;
  String? socialId;
  String? registerId;
  String? token;
  String? expiredAt;
  String? lastLogin;
  String? dateTime;
  String? otp;
  String? lat;
  String? lon;
  String? notifiStatus;
  String? countryCode;
  String? userStep;

  UsersDetails(
      {this.id,
        this.fullName,
        this.userName,
        this.mobile,
        this.email,
        this.password,
        this.image,
        this.type,
        this.status,
        this.socialId,
        this.registerId,
        this.token,
        this.expiredAt,
        this.lastLogin,
        this.dateTime,
        this.otp,
        this.lat,
        this.lon,
        this.notifiStatus,
        this.countryCode,
        this.userStep});

  UsersDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    userName = json['user_name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    type = json['type'];
    status = json['status'];
    socialId = json['social_id'];
    registerId = json['register_id'];
    token = json['token'];
    expiredAt = json['expired_at'];
    lastLogin = json['last_login'];
    dateTime = json['date_time'];
    otp = json['otp'];
    lat = json['lat'];
    lon = json['lon'];
    notifiStatus = json['notifi_status'];
    countryCode = json['country_code'];
    userStep = json['user_step'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image'] = this.image;
    data['type'] = this.type;
    data['status'] = this.status;
    data['social_id'] = this.socialId;
    data['register_id'] = this.registerId;
    data['token'] = this.token;
    data['expired_at'] = this.expiredAt;
    data['last_login'] = this.lastLogin;
    data['date_time'] = this.dateTime;
    data['otp'] = this.otp;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['notifi_status'] = this.notifiStatus;
    data['country_code'] = this.countryCode;
    data['user_step'] = this.userStep;
    return data;
  }
}
