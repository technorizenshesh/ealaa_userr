class getPostByCategoryModel {
  List<getPostByCategoryResult>? result;
  String? message;
  String? status;

  getPostByCategoryModel({this.result, this.message, this.status});

  getPostByCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <getPostByCategoryResult>[];
      json['result'].forEach((v) {
        result!.add(new getPostByCategoryResult.fromJson(v));
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

class getPostByCategoryResult {
  String? id;
  String? userId;
  String? cityId;
  String? price;
  String? size;
  String? categoryId;
  String? subCategoryId;
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
  String? image;
  String? mobile;
  String? plateType;
  String? plateSource;
  String? plateCode;
  String? plateDesign;
  String? plateNumber;
  String? autoAccessoriesType;
  String? age;
  String? condition;
  String? underWarranty;
  String? hIN;
  String? boatYachtType;
  String? make;
  String? length;
  String? color;
  String? serviceHistory;
  String? noofseats;
  String? motorbikeType;
  String? motorbikeMake;
  String? motorbikeModel;
  String? motorbikeCondition;
  String? regionalSpecs;
  String? kilometer;
  String? engineCapacity;
  String? numberofcylinders;
  String? fuelType;
  String? horsePower;
  String? rimsize;
  String? vIN;
  String? truckType;
  String? truckMake;
  String? modelYear;
  String? transmissionType;
  String? numberofDoors;
  String? vehiclemakes;
  String? vehicleModel;
  String? vehicleCondition;
  String? bodyType;
  String? driveType;
  String? brand;
  String? advertisementPostFav;

  getPostByCategoryResult(
      {this.id,
        this.userId,
        this.cityId,
        this.price,
        this.size,
        this.categoryId,
        this.subCategoryId,
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
        this.image,
        this.mobile,
        this.plateType,
        this.plateSource,
        this.plateCode,
        this.plateDesign,
        this.plateNumber,
        this.autoAccessoriesType,
        this.age,
        this.condition,
        this.underWarranty,
        this.hIN,
        this.boatYachtType,
        this.make,
        this.length,
        this.color,
        this.serviceHistory,
        this.noofseats,
        this.motorbikeType,
        this.motorbikeMake,
        this.motorbikeModel,
        this.motorbikeCondition,
        this.regionalSpecs,
        this.kilometer,
        this.engineCapacity,
        this.numberofcylinders,
        this.fuelType,
        this.horsePower,
        this.rimsize,
        this.vIN,
        this.truckType,
        this.truckMake,
        this.modelYear,
        this.transmissionType,
        this.numberofDoors,
        this.vehiclemakes,
        this.vehicleModel,
        this.vehicleCondition,
        this.bodyType,
        this.driveType,
        this.brand,
        this.advertisementPostFav});

  getPostByCategoryResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    price = json['price'];
    size = json['size'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
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
    image = json['image'];
    mobile = json['mobile'];
    plateType = json['plate_type'];
    plateSource = json['plate_source'];
    plateCode = json['plate_code'];
    plateDesign = json['plate_design'];
    plateNumber = json['plate_number'];
    autoAccessoriesType = json['auto_accessories_type'];
    age = json['age'];
    condition = json['condition'];
    underWarranty = json['under_warranty'];
    hIN = json['HIN'];
    boatYachtType = json['BoatYachtType'];
    make = json['Make'];
    length = json['Length'];
    color = json['color'];
    serviceHistory = json['ServiceHistory'];
    noofseats = json['Noofseats'];
    motorbikeType = json['MotorbikeType'];
    motorbikeMake = json['MotorbikeMake'];
    motorbikeModel = json['MotorbikeModel'];
    motorbikeCondition = json['MotorbikeCondition'];
    regionalSpecs = json['RegionalSpecs'];
    kilometer = json['Kilometer'];
    engineCapacity = json['EngineCapacity'];
    numberofcylinders = json['Numberofcylinders'];
    fuelType = json['FuelType'];
    horsePower = json['HorsePower'];
    rimsize = json['Rimsize'];
    vIN = json['VIN'];
    truckType = json['TruckType'];
    truckMake = json['TruckMake'];
    modelYear = json['ModelYear'];
    transmissionType = json['TransmissionType'];
    numberofDoors = json['NumberofDoors'];
    vehiclemakes = json['Vehiclemakes'];
    vehicleModel = json['VehicleModel'];
    vehicleCondition = json['VehicleCondition'];
    bodyType = json['BodyType'];
    driveType = json['DriveType'];
    brand = json['brand'];
    advertisementPostFav = json['advertisement_post_fav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['price'] = this.price;
    data['size'] = this.size;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
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
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    data['plate_type'] = this.plateType;
    data['plate_source'] = this.plateSource;
    data['plate_code'] = this.plateCode;
    data['plate_design'] = this.plateDesign;
    data['plate_number'] = this.plateNumber;
    data['auto_accessories_type'] = this.autoAccessoriesType;
    data['age'] = this.age;
    data['condition'] = this.condition;
    data['under_warranty'] = this.underWarranty;
    data['HIN'] = this.hIN;
    data['BoatYachtType'] = this.boatYachtType;
    data['Make'] = this.make;
    data['Length'] = this.length;
    data['color'] = this.color;
    data['ServiceHistory'] = this.serviceHistory;
    data['Noofseats'] = this.noofseats;
    data['MotorbikeType'] = this.motorbikeType;
    data['MotorbikeMake'] = this.motorbikeMake;
    data['MotorbikeModel'] = this.motorbikeModel;
    data['MotorbikeCondition'] = this.motorbikeCondition;
    data['RegionalSpecs'] = this.regionalSpecs;
    data['Kilometer'] = this.kilometer;
    data['EngineCapacity'] = this.engineCapacity;
    data['Numberofcylinders'] = this.numberofcylinders;
    data['FuelType'] = this.fuelType;
    data['HorsePower'] = this.horsePower;
    data['Rimsize'] = this.rimsize;
    data['VIN'] = this.vIN;
    data['TruckType'] = this.truckType;
    data['TruckMake'] = this.truckMake;
    data['ModelYear'] = this.modelYear;
    data['TransmissionType'] = this.transmissionType;
    data['NumberofDoors'] = this.numberofDoors;
    data['Vehiclemakes'] = this.vehiclemakes;
    data['VehicleModel'] = this.vehicleModel;
    data['VehicleCondition'] = this.vehicleCondition;
    data['BodyType'] = this.bodyType;
    data['DriveType'] = this.driveType;
    data['brand'] = this.brand;
    data['advertisement_post_fav'] = this.advertisementPostFav;
    return data;
  }
}
