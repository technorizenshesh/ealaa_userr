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
}

class VehiclesMakeResult {
  String? id;
  String? name;
  String? dateTime;
  String? image;
  String? type;
  String? categoryId;
  List<Model>? model;
  List<YearModel>? year;
  List<IdNameModel>? condition;
  List<IdNameModel>? engineSize;
  List<IdNameModel>? doors;
  List<IdNameModel>? exteriorColor;
  List<IdNameModel>? interiorColor;
  List<IdNameModel>? cylinders;
  List<IdNameModel>? fuel;
  List<IdNameModel>? transmission;
  List<IdNameModel>? drivetrain;
  List<IdNameModel>? seats;
  List<IdNameModel>? plate;
  List<IdNameModel>? origin;
  List<IdNameModel>? governate;
  List<StateModel>? state;

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
    if (json['year'] != null) {
      year = <YearModel>[];
      json['year'].forEach((v) {
        year!.add(new YearModel.fromJson(v));
      });
    }
    if (json['condition'] != null) {
      condition = <IdNameModel>[];
      json['condition'].forEach((v) {
        condition!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['engineSize'] != null) {
      engineSize = <IdNameModel>[];
      json['engineSize'].forEach((v) {
        engineSize!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['doors'] != null) {
      doors = <IdNameModel>[];
      json['doors'].forEach((v) {
        doors!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['exteriorColor'] != null) {
      exteriorColor = <IdNameModel>[];
      json['exteriorColor'].forEach((v) {
        exteriorColor!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['interiorColor'] != null) {
      interiorColor = <IdNameModel>[];
      json['interiorColor'].forEach((v) {
        interiorColor!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['cylinders'] != null) {
      cylinders = <IdNameModel>[];
      json['cylinders'].forEach((v) {
        cylinders!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['fuel'] != null) {
      fuel = <IdNameModel>[];
      json['fuel'].forEach((v) {
        fuel!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['transmission'] != null) {
      transmission = <IdNameModel>[];
      json['transmission'].forEach((v) {
        transmission!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['drivetrain'] != null) {
      drivetrain = <IdNameModel>[];
      json['drivetrain'].forEach((v) {
        drivetrain!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['seats'] != null) {
      seats = <IdNameModel>[];
      json['seats'].forEach((v) {
        seats!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['plate'] != null) {
      plate = <IdNameModel>[];
      json['plate'].forEach((v) {
        plate!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['origin'] != null) {
      origin = <IdNameModel>[];
      json['origin'].forEach((v) {
        origin!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['governate'] != null) {
      governate = <IdNameModel>[];
      json['governate'].forEach((v) {
        governate!.add(new IdNameModel.fromJson(v));
      });
    }
    if (json['state'] != null) {
      state = <StateModel>[];
      json['state'].forEach((v) {
        state!.add(new StateModel.fromJson(v));
      });
    }
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
  List<ModelYear>? modelYear;

  Model(
      {this.id,
        this.name,
        this.image,
        this.dateTime,
        this.type,
        this.makerId,
        this.modelTrim,
        this.modelYear});

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
    if (json['model_year'] != null) {
      modelYear = <ModelYear>[];
      json['model_year'].forEach((v) {
        modelYear!.add(new ModelYear.fromJson(v));
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
    if (this.modelYear != null) {
      data['model_year'] = this.modelYear!.map((v) => v.toJson()).toList();
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

class ModelYear {
  String? yearId;
  String? yearName;
  String? yearCreatedAt;
  String? yearUpdatedAt;
  Null? yearDeletedAt;
  String? yearAdminStatus;

  ModelYear(
      {this.yearId,
        this.yearName,
        this.yearCreatedAt,
        this.yearUpdatedAt,
        this.yearDeletedAt,
        this.yearAdminStatus});

  ModelYear.fromJson(Map<String, dynamic> json) {
    yearId = json['year_id'];
    yearName = json['year_name'];
    yearCreatedAt = json['year_created_at'];
    yearUpdatedAt = json['year_updated_at'];
    yearDeletedAt = json['year_deleted_at'];
    yearAdminStatus = json['year_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year_id'] = this.yearId;
    data['year_name'] = this.yearName;
    data['year_created_at'] = this.yearCreatedAt;
    data['year_updated_at'] = this.yearUpdatedAt;
    data['year_deleted_at'] = this.yearDeletedAt;
    data['year_admin_status'] = this.yearAdminStatus;
    return data;
  }
}

class YearModel {
  String? id;
  String? year;

  YearModel({this.id, this.year});

  YearModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    return data;
  }
}

class IdNameModel {
  String? id;
  String? name;
  String? code;

  IdNameModel({this.id, this.name});

  IdNameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class StateModel {
  String? stateId;
  String? governorateId;
  String? stateName;
  String? stateCreatedAt;
  String? stateUpdatedAt;
  Null? stateDeletedAt;
  String? stateAdminStatus;

  StateModel(
      {this.stateId,
        this.governorateId,
        this.stateName,
        this.stateCreatedAt,
        this.stateUpdatedAt,
        this.stateDeletedAt,
        this.stateAdminStatus});

  StateModel.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    governorateId = json['governorate_id'];
    stateName = json['state_name'];
    stateCreatedAt = json['state_created_at'];
    stateUpdatedAt = json['state_updated_at'];
    stateDeletedAt = json['state_deleted_at'];
    stateAdminStatus = json['state_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['governorate_id'] = this.governorateId;
    data['state_name'] = this.stateName;
    data['state_created_at'] = this.stateCreatedAt;
    data['state_updated_at'] = this.stateUpdatedAt;
    data['state_deleted_at'] = this.stateDeletedAt;
    data['state_admin_status'] = this.stateAdminStatus;
    return data;
  }
}








/*
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
  List<String>? cylinders;
  List<String>? fuel;
  List<String>? transmission;
  List<String>? drivetrain;
  List<String>? seats;
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
    cylinders = json['cylinders'].cast<String>();
    fuel = json['fuel'].cast<String>();
    transmission = json['transmission'].cast<String>();
    drivetrain = json['drivetrain'].cast<String>();
    seats = json['seats'].cast<String>();
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
  List<ModelYear>? modelYear;

  Model(
      {this.id,
        this.name,
        this.image,
        this.dateTime,
        this.type,
        this.makerId,
        this.modelTrim,
        this.modelYear});

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
    if (json['model_year'] != null) {
      modelYear = <ModelYear>[];
      json['model_year'].forEach((v) {
        modelYear!.add(new ModelYear.fromJson(v));
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
    if (this.modelYear != null) {
      data['model_year'] = this.modelYear!.map((v) => v.toJson()).toList();
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

class ModelYear {
  int? yearId;
  String? yearName;

  ModelYear({this.yearId, this.yearName});

  ModelYear.fromJson(Map<String, dynamic> json) {
    yearId = json['year_id'];
    yearName = json['year_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year_id'] = this.yearId;
    data['year_name'] = this.yearName;
    return data;
  }
}
*/
