class VehiclePartsModel {
  VehiclePartsResult? result;
  String? message;
  String? status;

  VehiclePartsModel({this.result, this.message, this.status});

  VehiclePartsModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new VehiclePartsResult.fromJson(json['result']) : null;
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

class VehiclePartsResult {
  List<Part>? part;
  List<Maker>? maker;
  List<EngineSize>? engineSize;
  List<Governorate>? governorate;

  VehiclePartsResult({this.part, this.maker, this.engineSize, this.governorate});

  VehiclePartsResult.fromJson(Map<String, dynamic> json) {
    if (json['part'] != null) {
      part = <Part>[];
      json['part'].forEach((v) {
        part!.add(new Part.fromJson(v));
      });
    }
    if (json['maker'] != null) {
      maker = <Maker>[];
      json['maker'].forEach((v) {
        maker!.add(new Maker.fromJson(v));
      });
    }
    if (json['engine_size'] != null) {
      engineSize = <EngineSize>[];
      json['engine_size'].forEach((v) {
        engineSize!.add(new EngineSize.fromJson(v));
      });
    }
    if (json['governorate'] != null) {
      governorate = <Governorate>[];
      json['governorate'].forEach((v) {
        governorate!.add(new Governorate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.part != null) {
      data['part'] = this.part!.map((v) => v.toJson()).toList();
    }
    if (this.maker != null) {
      data['maker'] = this.maker!.map((v) => v.toJson()).toList();
    }
    if (this.engineSize != null) {
      data['engine_size'] = this.engineSize!.map((v) => v.toJson()).toList();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Part {
  String? partId;
  String? partName;
  String? partCreatedAt;
  String? partUpdatedAt;
  Null? partDeletedAt;
  String? partAdminStatus;
  List<SubPartName>? subPartName;

  Part(
      {this.partId,
        this.partName,
        this.partCreatedAt,
        this.partUpdatedAt,
        this.partDeletedAt,
        this.partAdminStatus,
        this.subPartName});

  Part.fromJson(Map<String, dynamic> json) {
    partId = json['part_id'];
    partName = json['part_name'];
    partCreatedAt = json['part_created_at'];
    partUpdatedAt = json['part_updated_at'];
    partDeletedAt = json['part_deleted_at'];
    partAdminStatus = json['part_admin_status'];
    if (json['sub_part_name'] != null) {
      subPartName = <SubPartName>[];
      json['sub_part_name'].forEach((v) {
        subPartName!.add(new SubPartName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['part_id'] = this.partId;
    data['part_name'] = this.partName;
    data['part_created_at'] = this.partCreatedAt;
    data['part_updated_at'] = this.partUpdatedAt;
    data['part_deleted_at'] = this.partDeletedAt;
    data['part_admin_status'] = this.partAdminStatus;
    if (this.subPartName != null) {
      data['sub_part_name'] = this.subPartName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubPartName {
  String? subPartId;
  String? partId;
  String? subPartName;
  String? subPartCreatedAt;
  String? subPartUpdatedAt;
  Null? subPartDeletedAt;
  String? subPartAdminStatus;

  SubPartName(
      {this.subPartId,
        this.partId,
        this.subPartName,
        this.subPartCreatedAt,
        this.subPartUpdatedAt,
        this.subPartDeletedAt,
        this.subPartAdminStatus});

  SubPartName.fromJson(Map<String, dynamic> json) {
    subPartId = json['sub_part_id'];
    partId = json['part_id'];
    subPartName = json['sub_part_name'];
    subPartCreatedAt = json['sub_part_created_at'];
    subPartUpdatedAt = json['sub_part_updated_at'];
    subPartDeletedAt = json['sub_part_deleted_at'];
    subPartAdminStatus = json['sub_part_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_part_id'] = this.subPartId;
    data['part_id'] = this.partId;
    data['sub_part_name'] = this.subPartName;
    data['sub_part_created_at'] = this.subPartCreatedAt;
    data['sub_part_updated_at'] = this.subPartUpdatedAt;
    data['sub_part_deleted_at'] = this.subPartDeletedAt;
    data['sub_part_admin_status'] = this.subPartAdminStatus;
    return data;
  }
}

class Maker {
  String? id;
  String? name;
  String? dateTime;
  String? image;
  String? type;
  String? categoryId;
  List<Model>? model;

  Maker(
      {this.id,
        this.name,
        this.dateTime,
        this.image,
        this.type,
        this.categoryId,
        this.model});

  Maker.fromJson(Map<String, dynamic> json) {
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

class EngineSize {
  String? engineId;
  String? engineValue;
  String? engineCreatedAt;
  String? engineUpdatedAt;
  Null? engineDeletedAt;
  String? engineAdminStatus;

  EngineSize(
      {this.engineId,
        this.engineValue,
        this.engineCreatedAt,
        this.engineUpdatedAt,
        this.engineDeletedAt,
        this.engineAdminStatus});

  EngineSize.fromJson(Map<String, dynamic> json) {
    engineId = json['engine_id'];
    engineValue = json['engine_value'];
    engineCreatedAt = json['engine_created_at'];
    engineUpdatedAt = json['engine_updated_at'];
    engineDeletedAt = json['engine_deleted_at'];
    engineAdminStatus = json['engine_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['engine_id'] = this.engineId;
    data['engine_value'] = this.engineValue;
    data['engine_created_at'] = this.engineCreatedAt;
    data['engine_updated_at'] = this.engineUpdatedAt;
    data['engine_deleted_at'] = this.engineDeletedAt;
    data['engine_admin_status'] = this.engineAdminStatus;
    return data;
  }
}

class Governorate {
  String? governorateId;
  String? governorateName;
  String? governorateCreatedAt;
  String? governorateUpdatedAt;
  Null? governorateDeletedAt;
  String? governorateAdminStatus;
  List<GovernorateState>? governorateState;

  Governorate(
      {this.governorateId,
        this.governorateName,
        this.governorateCreatedAt,
        this.governorateUpdatedAt,
        this.governorateDeletedAt,
        this.governorateAdminStatus,
        this.governorateState});

  Governorate.fromJson(Map<String, dynamic> json) {
    governorateId = json['governorate_id'];
    governorateName = json['governorate_name'];
    governorateCreatedAt = json['governorate_created_at'];
    governorateUpdatedAt = json['governorate_updated_at'];
    governorateDeletedAt = json['governorate_deleted_at'];
    governorateAdminStatus = json['governorate_admin_status'];
    if (json['governorate_state'] != null) {
      governorateState = <GovernorateState>[];
      json['governorate_state'].forEach((v) {
        governorateState!.add(new GovernorateState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['governorate_id'] = this.governorateId;
    data['governorate_name'] = this.governorateName;
    data['governorate_created_at'] = this.governorateCreatedAt;
    data['governorate_updated_at'] = this.governorateUpdatedAt;
    data['governorate_deleted_at'] = this.governorateDeletedAt;
    data['governorate_admin_status'] = this.governorateAdminStatus;
    if (this.governorateState != null) {
      data['governorate_state'] =
          this.governorateState!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GovernorateState {
  String? stateId;
  String? governorateId;
  String? stateName;
  String? stateCreatedAt;
  String? stateUpdatedAt;
  Null? stateDeletedAt;
  String? stateAdminStatus;
  List<StateCity>? stateCity;

  GovernorateState(
      {this.stateId,
        this.governorateId,
        this.stateName,
        this.stateCreatedAt,
        this.stateUpdatedAt,
        this.stateDeletedAt,
        this.stateAdminStatus,
        this.stateCity});

  GovernorateState.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    governorateId = json['governorate_id'];
    stateName = json['state_name'];
    stateCreatedAt = json['state_created_at'];
    stateUpdatedAt = json['state_updated_at'];
    stateDeletedAt = json['state_deleted_at'];
    stateAdminStatus = json['state_admin_status'];
    if (json['state_city'] != null) {
      stateCity = <StateCity>[];
      json['state_city'].forEach((v) {
        stateCity!.add(new StateCity.fromJson(v));
      });
    }
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
    if (this.stateCity != null) {
      data['state_city'] = this.stateCity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateCity {
  String? cityId;
  String? stateId;
  String? cityName;
  String? cityCreatedAt;
  String? cityUpdatedAt;
  Null? cityDeletedAt;
  String? cityAdminStatus;

  StateCity(
      {this.cityId,
        this.stateId,
        this.cityName,
        this.cityCreatedAt,
        this.cityUpdatedAt,
        this.cityDeletedAt,
        this.cityAdminStatus});

  StateCity.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
    cityCreatedAt = json['city_created_at'];
    cityUpdatedAt = json['city_updated_at'];
    cityDeletedAt = json['city_deleted_at'];
    cityAdminStatus = json['city_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['city_name'] = this.cityName;
    data['city_created_at'] = this.cityCreatedAt;
    data['city_updated_at'] = this.cityUpdatedAt;
    data['city_deleted_at'] = this.cityDeletedAt;
    data['city_admin_status'] = this.cityAdminStatus;
    return data;
  }
}
