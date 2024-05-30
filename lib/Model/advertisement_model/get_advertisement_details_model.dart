class GetAdvertisementDetailsModel {
  GetAdvertisementDetailsResult? result;
  String? message;
  String? status;

  GetAdvertisementDetailsModel({this.result, this.message, this.status});

  GetAdvertisementDetailsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? GetAdvertisementDetailsResult.fromJson(json['result'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class GetAdvertisementDetailsResult {
  String? id;
  String? userId;
  String? image;
  String? tourUrl360;
  String? youtubeUrl;
  String? phoneNumber;
  String? price;
  String? describeProperty;
  String? size;
  String? totalClosingFee;
  String? developer;
  String? readyBy;
  String? propertyReferenceId;
  String? buyerTransferFee;
  String? sellerTransferFee;
  String? landlord;
  String? retail;
  String? maintenanceFee;
  String? occupancyStatus;
  String? building;
  String? locateProperty;
  String? locationPin;
  String? dateTime;
  String? bedroom;
  String? advertisementCategoryId;
  UserDetails? userDetails;
  String? advertisementPostFav;
  String? count;

  GetAdvertisementDetailsResult(
      {this.id,
      this.userId,
      this.image,
      this.tourUrl360,
      this.youtubeUrl,
      this.phoneNumber,
      this.price,
      this.describeProperty,
      this.size,
      this.totalClosingFee,
      this.developer,
      this.readyBy,
      this.propertyReferenceId,
      this.buyerTransferFee,
      this.sellerTransferFee,
      this.landlord,
      this.retail,
      this.maintenanceFee,
      this.occupancyStatus,
      this.building,
      this.locateProperty,
      this.locationPin,
      this.dateTime,
      this.bedroom,
      this.advertisementCategoryId,
      this.advertisementPostFav,
      this.count,
      this.userDetails});

  GetAdvertisementDetailsResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    tourUrl360 = json['tour_url_360'];
    youtubeUrl = json['youtube_url'];
    phoneNumber = json['phone_number'];
    price = json['price'];
    describeProperty = json['describe_property'];
    size = json['size'];
    totalClosingFee = json['total_closing_fee'];
    developer = json['developer'];
    readyBy = json['ready_by'];
    propertyReferenceId = json['property_reference_id'];
    buyerTransferFee = json['buyer_transfer_fee'];
    sellerTransferFee = json['seller_transfer_fee'];
    landlord = json['landlord'];
    retail = json['retail'];
    maintenanceFee = json['maintenance_fee'];
    occupancyStatus = json['occupancy_status'];
    building = json['building'];
    locateProperty = json['locate_property'];
    locationPin = json['location_pin'];
    dateTime = json['date_time'];
    bedroom = json['bedroom'];
    advertisementCategoryId = json['advertisement_category_id'];
    advertisementPostFav = json['advertisement_post_fav'] ?? 'false';
    count = json['count'] ?? '0';
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['tour_url_360'] = tourUrl360;
    data['youtube_url'] = youtubeUrl;
    data['phone_number'] = phoneNumber;
    data['price'] = price;
    data['describe_property'] = describeProperty;
    data['size'] = size;
    data['total_closing_fee'] = totalClosingFee;
    data['developer'] = developer;
    data['ready_by'] = readyBy;
    data['property_reference_id'] = propertyReferenceId;
    data['buyer_transfer_fee'] = buyerTransferFee;
    data['seller_transfer_fee'] = sellerTransferFee;
    data['landlord'] = landlord;
    data['retail'] = retail;
    data['maintenance_fee'] = maintenanceFee;
    data['occupancy_status'] = occupancyStatus;
    data['building'] = building;
    data['locate_property'] = locateProperty;
    data['location_pin'] = locationPin;
    data['date_time'] = dateTime;
    data['bedroom'] = bedroom;
    data['advertisement_category_id'] = advertisementCategoryId;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
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

  UserDetails(
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

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['user_name'] = userName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    data['type'] = type;
    data['status'] = status;
    data['social_id'] = socialId;
    data['register_id'] = registerId;
    data['token'] = token;
    data['expired_at'] = expiredAt;
    data['last_login'] = lastLogin;
    data['date_time'] = dateTime;
    data['otp'] = otp;
    data['lat'] = lat;
    data['lon'] = lon;
    data['notifi_status'] = notifiStatus;
    data['country_code'] = countryCode;
    data['user_step'] = userStep;
    return data;
  }
}
