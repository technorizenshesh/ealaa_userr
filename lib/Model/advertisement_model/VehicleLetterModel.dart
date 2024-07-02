class VehicleLetterModel {
  VehicleLetterResult? result;
  String? message;
  String? status;

  VehicleLetterModel({this.result, this.message, this.status});

  VehicleLetterModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new VehicleLetterResult.fromJson(json['result']) : null;
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

class VehicleLetterResult {
  List<Letters>? letters;
  List<PlateTypes>? plateTypes;
  List<Governorate>? governorate;

  VehicleLetterResult({this.letters, this.plateTypes, this.governorate});

  VehicleLetterResult.fromJson(Map<String, dynamic> json) {
    if (json['letters'] != null) {
      letters = <Letters>[];
      json['letters'].forEach((v) {
        letters!.add(new Letters.fromJson(v));
      });
    }
    if (json['plate_types'] != null) {
      plateTypes = <PlateTypes>[];
      json['plate_types'].forEach((v) {
        plateTypes!.add(new PlateTypes.fromJson(v));
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
    if (this.letters != null) {
      data['letters'] = this.letters!.map((v) => v.toJson()).toList();
    }
    if (this.plateTypes != null) {
      data['plate_types'] = this.plateTypes!.map((v) => v.toJson()).toList();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Letters {
  String? letterId;
  String? letterNameEnglish;
  String? letterNameArabic;
  String? letterCreatedAt;
  String? letterUpdatedAt;
  Null? letterDeletedAt;
  String? letterAdminStatus;

  Letters(
      {this.letterId,
        this.letterNameEnglish,
        this.letterNameArabic,
        this.letterCreatedAt,
        this.letterUpdatedAt,
        this.letterDeletedAt,
        this.letterAdminStatus});

  Letters.fromJson(Map<String, dynamic> json) {
    letterId = json['letter_id'];
    letterNameEnglish = json['letter_name_english'];
    letterNameArabic = json['letter_name_arabic'];
    letterCreatedAt = json['letter_created_at'];
    letterUpdatedAt = json['letter_updated_at'];
    letterDeletedAt = json['letter_deleted_at'];
    letterAdminStatus = json['letter_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['letter_id'] = this.letterId;
    data['letter_name_english'] = this.letterNameEnglish;
    data['letter_name_arabic'] = this.letterNameArabic;
    data['letter_created_at'] = this.letterCreatedAt;
    data['letter_updated_at'] = this.letterUpdatedAt;
    data['letter_deleted_at'] = this.letterDeletedAt;
    data['letter_admin_status'] = this.letterAdminStatus;
    return data;
  }
}

class PlateTypes {
  String? plateTypeId;
  String? plateTypeName;
  String? plateTypeCreatedAt;
  String? plateTypeUpdatedAt;
  Null? plateTypeDeletedAt;
  String? plateTypeAdminStatus;

  PlateTypes(
      {this.plateTypeId,
        this.plateTypeName,
        this.plateTypeCreatedAt,
        this.plateTypeUpdatedAt,
        this.plateTypeDeletedAt,
        this.plateTypeAdminStatus});

  PlateTypes.fromJson(Map<String, dynamic> json) {
    plateTypeId = json['plate_type_id'];
    plateTypeName = json['plate_type_name'];
    plateTypeCreatedAt = json['plate_type_created_at'];
    plateTypeUpdatedAt = json['plate_type_updated_at'];
    plateTypeDeletedAt = json['plate_type_deleted_at'];
    plateTypeAdminStatus = json['plate_type_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plate_type_id'] = this.plateTypeId;
    data['plate_type_name'] = this.plateTypeName;
    data['plate_type_created_at'] = this.plateTypeCreatedAt;
    data['plate_type_updated_at'] = this.plateTypeUpdatedAt;
    data['plate_type_deleted_at'] = this.plateTypeDeletedAt;
    data['plate_type_admin_status'] = this.plateTypeAdminStatus;
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
