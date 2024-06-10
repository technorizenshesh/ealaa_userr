class AddPostModel {
  AddPostResult? result;
  String? message;
  String? status;

  AddPostModel({this.result, this.message, this.status});

  AddPostModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new AddPostResult.fromJson(json['result']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class AddPostResult {
  String? id;
  String? userId;
  String? cityId;
  String? price;
  String? size;
  String? categoryId;
  String? bedroom;
  String? bathroom;
  String? acType;
  String? electricityInclusive;
  String? swimmingPool;
  String? gym;
  String? dateTime;
  String? referenceNumber;
  String? furnished;
  String? playArea;
  String? numberOfFloors;
  String? maintenanceIncluded;
  String? extraFeatures;
  String? description;
  String? tourUrl;
  String? youtubeUrl;
  String? address;
  String? shortsDescription;
  String? subCategoryId;
  String? image;
  String? mobile;

  AddPostResult(
      {this.id,
        this.userId,
        this.cityId,
        this.price,
        this.size,
        this.categoryId,
        this.bedroom,
        this.bathroom,
        this.acType,
        this.electricityInclusive,
        this.swimmingPool,
        this.gym,
        this.dateTime,
        this.referenceNumber,
        this.furnished,
        this.playArea,
        this.numberOfFloors,
        this.maintenanceIncluded,
        this.extraFeatures,
        this.description,
        this.tourUrl,
        this.youtubeUrl,
        this.address,
        this.shortsDescription,
        this.subCategoryId,
        this.image,
        this.mobile});

  AddPostResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    price = json['price'];
    size = json['size'];
    categoryId = json['category_id'];
    bedroom = json['bedroom'];
    bathroom = json['bathroom'];
    acType = json['ac_type'];
    electricityInclusive = json['electricity_inclusive'];
    swimmingPool = json['swimming_pool'];
    gym = json['gym'];
    dateTime = json['date_time'];
    referenceNumber = json['reference_number'];
    furnished = json['furnished'];
    playArea = json['play_area'];
    numberOfFloors = json['number_of_floors'];
    maintenanceIncluded = json['maintenance_included'];
    extraFeatures = json['extra_features'];
    description = json['description'];
    tourUrl = json['tour_url'];
    youtubeUrl = json['youtube_url'];
    address = json['address'];
    shortsDescription = json['shorts_description'];
    subCategoryId = json['sub_category_id'];
    image = json['image'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['price'] = this.price;
    data['size'] = this.size;
    data['category_id'] = this.categoryId;
    data['bedroom'] = this.bedroom;
    data['bathroom'] = this.bathroom;
    data['ac_type'] = this.acType;
    data['electricity_inclusive'] = this.electricityInclusive;
    data['swimming_pool'] = this.swimmingPool;
    data['gym'] = this.gym;
    data['date_time'] = this.dateTime;
    data['reference_number'] = this.referenceNumber;
    data['furnished'] = this.furnished;
    data['play_area'] = this.playArea;
    data['number_of_floors'] = this.numberOfFloors;
    data['maintenance_included'] = this.maintenanceIncluded;
    data['extra_features'] = this.extraFeatures;
    data['description'] = this.description;
    data['tour_url'] = this.tourUrl;
    data['youtube_url'] = this.youtubeUrl;
    data['address'] = this.address;
    data['shorts_description'] = this.shortsDescription;
    data['sub_category_id'] = this.subCategoryId;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    return data;
  }
}
