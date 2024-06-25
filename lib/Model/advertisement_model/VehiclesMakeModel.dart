class VehiclesMakeModel {
  List<VehiclesMakeResult>? result;
  String? message;
  String? status;

  VehiclesMakeModel({this.result, this.message, this.status});

  VehiclesMakeModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <VehiclesMakeResult>[];
      json['result'].forEach((v) {
        result!.add(new VehiclesMakeResult.fromJson(v));
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

class VehiclesMakeResult {
  String? id;
  String? name;
  String? dateTime;
  String? image;
  String? type;
  String? categoryId;
  List<Model>? model;
  List<int>? year;
  List<String>? condition;
  List<String>? engineSize;
  List<int>? doors;
  List<String>? exteriorColor;
  List<String>? interiorColor;
  List<int>? cylinders;
  List<String>? fuel;
  List<String>? transmission;
  List<String>? drivetrain;
  List<int>? seats;
  List<String>? plate;
  List<String>? origin;
  List<String>? governate;
  List<String>? state;

  VehiclesMakeResult(
      {this.id,
        this.name,
        this.dateTime,
        this.image,
        this.type,
        this.categoryId,
        this.model,
        this.year,
        this.condition,
        this.engineSize,
        this.doors,
        this.exteriorColor,
        this.interiorColor,
        this.cylinders,
        this.fuel,
        this.transmission,
        this.drivetrain,
        this.seats,
        this.plate,
        this.origin,
        this.governate,
        this.state});

  VehiclesMakeResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateTime = json['date_time'];
    image = json['image'];
    type = json['type'];
    categoryId = json['category_id'];
    if (json['model'] != null) {
      model = <Model>[];
      json['model'].forEach((v) {
        model!.add(new Model.fromJson(v));
      });
    }
    year = json['year'].cast<int>();
    condition = json['condition'].cast<String>();
    engineSize = json['engineSize'].cast<String>();
    doors = json['doors'].cast<int>();
    exteriorColor = json['exteriorColor'].cast<String>();
    interiorColor = json['interiorColor'].cast<String>();
    cylinders = json['cylinders'].cast<int>();
    fuel = json['fuel'].cast<String>();
    transmission = json['transmission'].cast<String>();
    drivetrain = json['drivetrain'].cast<String>();
    seats = json['seats'].cast<int>();
    plate = json['plate'].cast<String>();
    origin = json['origin'].cast<String>();
    governate = json['governate'].cast<String>();
    state = json['state'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date_time'] = this.dateTime;
    data['image'] = this.image;
    data['type'] = this.type;
    data['category_id'] = this.categoryId;
    if (this.model != null) {
      data['model'] = this.model!.map((v) => v.toJson()).toList();
    }
    data['year'] = this.year;
    data['condition'] = this.condition;
    data['engineSize'] = this.engineSize;
    data['doors'] = this.doors;
    data['exteriorColor'] = this.exteriorColor;
    data['interiorColor'] = this.interiorColor;
    data['cylinders'] = this.cylinders;
    data['fuel'] = this.fuel;
    data['transmission'] = this.transmission;
    data['drivetrain'] = this.drivetrain;
    data['seats'] = this.seats;
    data['plate'] = this.plate;
    data['origin'] = this.origin;
    data['governate'] = this.governate;
    data['state'] = this.state;
    return data;
  }
}

class Model {
  String? id;
  String? name;
  String? image;
  String? dateTime;
  String? type;
  String? makerId;
  List<ModelTrim>? modelTrim;

  Model(
      {this.id,
        this.name,
        this.image,
        this.dateTime,
        this.type,
        this.makerId,
        this.modelTrim});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    dateTime = json['date_time'];
    type = json['type'];
    makerId = json['maker_id'];
    if (json['model_trim'] != null) {
      modelTrim = <ModelTrim>[];
      json['model_trim'].forEach((v) {
        modelTrim!.add(new ModelTrim.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['date_time'] = this.dateTime;
    data['type'] = this.type;
    data['maker_id'] = this.makerId;
    if (this.modelTrim != null) {
      data['model_trim'] = this.modelTrim!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelTrim {
  String? id;
  String? name;
  String? image;
  String? dateTime;
  String? modelId;

  ModelTrim({this.id, this.name, this.image, this.dateTime, this.modelId});

  ModelTrim.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    dateTime = json['date_time'];
    modelId = json['model_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['date_time'] = this.dateTime;
    data['model_id'] = this.modelId;
    return data;
  }
}
