/*
class GetAdvertisementCategoryModel {
  List<GetAdvertisementCategoryResult>? result;
  String? message;
  String? status;

  GetAdvertisementCategoryModel({this.result, this.message, this.status});

  GetAdvertisementCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetAdvertisementCategoryResult>[];
      json['result'].forEach((v) {
        result!.add(GetAdvertisementCategoryResult.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class GetAdvertisementCategoryResult {
  String? id;
  String? name;
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
  String? advertisementPostFav;

  GetAdvertisementCategoryResult({
    this.id,
    this.name,
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
    this.advertisementPostFav,
    this.advertisementCategoryId,
  });

  GetAdvertisementCategoryResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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
    return data;
  }
}
*/
