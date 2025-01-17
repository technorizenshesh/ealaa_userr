class ElectronicsBrandModel {
  ElectronicsBrandResult? result;
  String? message;
  String? status;

  ElectronicsBrandModel({this.result, this.message, this.status});

  ElectronicsBrandModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new ElectronicsBrandResult.fromJson(json['result']) : null;
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

class ElectronicsBrandResult {
  List<Brand>? brand;
  List<Storage>? storage;
  List<Condition>? condition;
  List<Warranty>? warranty;
  List<Governorate>? governorate;

  ElectronicsBrandResult(
      {this.brand,
        this.storage,
        this.condition,
        this.warranty,
        this.governorate});

  ElectronicsBrandResult.fromJson(Map<String, dynamic> json) {
    if (json['brand'] != null) {
      brand = <Brand>[];
      json['brand'].forEach((v) {
        brand!.add(new Brand.fromJson(v));
      });
    }
    if (json['storage'] != null) {
      storage = <Storage>[];
      json['storage'].forEach((v) {
        storage!.add(new Storage.fromJson(v));
      });
    }
    if (json['condition'] != null) {
      condition = <Condition>[];
      json['condition'].forEach((v) {
        condition!.add(new Condition.fromJson(v));
      });
    }
    if (json['warranty'] != null) {
      warranty = <Warranty>[];
      json['warranty'].forEach((v) {
        warranty!.add(new Warranty.fromJson(v));
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
    if (this.brand != null) {
      data['brand'] = this.brand!.map((v) => v.toJson()).toList();
    }
    if (this.storage != null) {
      data['storage'] = this.storage!.map((v) => v.toJson()).toList();
    }
    if (this.condition != null) {
      data['condition'] = this.condition!.map((v) => v.toJson()).toList();
    }
    if (this.warranty != null) {
      data['warranty'] = this.warranty!.map((v) => v.toJson()).toList();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brand {
  String? brandId;
  String? name;
  List<BrandModel>? brandModel;

  Brand({this.brandId, this.name, this.brandModel});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    name = json['name'];
    if (json['brand_model'] != null && json['brand_model'].toString().isNotEmpty) {
      brandModel = <BrandModel>[];
      json['brand_model'].forEach((v) {
        brandModel!.add(new BrandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    if (this.brandModel != null) {
      data['brand_model'] = this.brandModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandModel {
  String? modelId;
  String? modelName;
  String? brandId;

  BrandModel({this.modelId, this.modelName, this.brandId});

  BrandModel.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    modelName = json['model_name'];
    brandId = json['brand_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['model_name'] = this.modelName;
    data['brand_id'] = this.brandId;
    return data;
  }
}

class Storage {
  String? storageId;
  String? storageName;

  Storage({this.storageId, this.storageName});

  Storage.fromJson(Map<String, dynamic> json) {
    storageId = json['storage_id'];
    storageName = json['storage_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storage_id'] = this.storageId;
    data['storage_name'] = this.storageName;
    return data;
  }
}

class Condition {
  String? conditionId;
  String? conditionName;

  Condition({this.conditionId, this.conditionName});

  Condition.fromJson(Map<String, dynamic> json) {
    conditionId = json['condition_id'];
    conditionName = json['condition_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition_id'] = this.conditionId;
    data['condition_name'] = this.conditionName;
    return data;
  }
}

class Warranty {
  String? warrantyId;
  String? warrantyName;

  Warranty({this.warrantyId, this.warrantyName});

  Warranty.fromJson(Map<String, dynamic> json) {
    warrantyId = json['warranty_id'];
    warrantyName = json['warranty_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_id'] = this.warrantyId;
    data['warranty_name'] = this.warrantyName;
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
