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
  int? brandId;
  String? brandName;
  List<BrandModel>? brandModel;

  Brand({this.brandId, this.brandName, this.brandModel});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    if (json['brand_model'] != null) {
      brandModel = <BrandModel>[];
      json['brand_model'].forEach((v) {
        brandModel!.add(new BrandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    if (this.brandModel != null) {
      data['brand_model'] = this.brandModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandModel {
  int? modelId;
  String? modelName;

  BrandModel({this.modelId, this.modelName});

  BrandModel.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    modelName = json['model_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['model_name'] = this.modelName;
    return data;
  }
}

class Storage {
  String? storageId;
  String? storageName;

  Storage({this.storageId, this.storageName});

  Storage.fromJson(Map<String, dynamic> json) {
    storageId = json['storage_id'].toString();
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
    conditionId = json['condition_id'].toString();
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
    warrantyId = json['warranty_id'].toString();
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
  List<GovernorateState>? governorateState;

  Governorate(
      {this.governorateId, this.governorateName, this.governorateState});

  Governorate.fromJson(Map<String, dynamic> json) {
    governorateId = json['governorate_id'].toString();
    governorateName = json['governorate_name'];
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
    if (this.governorateState != null) {
      data['governorate_state'] =
          this.governorateState!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GovernorateState {
  String? stateId;
  String? stateName;
  List<StateCity>? stateCity;

  GovernorateState({this.stateId, this.stateName, this.stateCity});

  GovernorateState.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'].toString();
    stateName = json['state_name'];
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
    data['state_name'] = this.stateName;
    if (this.stateCity != null) {
      data['state_city'] = this.stateCity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateCity {
  String? cityId;
  String? cityName;

  StateCity({this.cityId, this.cityName});

  StateCity.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'].toString();
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    return data;
  }
}
