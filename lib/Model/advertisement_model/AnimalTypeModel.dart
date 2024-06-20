class AnimalTypeModel {
  AnimalTypeResult? result;
  String? message;
  String? status;

  AnimalTypeModel({this.result, this.message, this.status});

  AnimalTypeModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new AnimalTypeResult.fromJson(json['result']) : null;
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

class AnimalTypeResult {
  List<Type>? type;
  List<Gender>? gender;
  List<Age>? age;
  List<BreedOrigin>? breedOrigin;
  List<Governorate>? governorate;

  AnimalTypeResult(
      {this.type, this.gender, this.age, this.breedOrigin, this.governorate});

  AnimalTypeResult.fromJson(Map<String, dynamic> json) {
    if (json['type'] != null) {
      type = <Type>[];
      json['type'].forEach((v) {
        type!.add(new Type.fromJson(v));
      });
    }
    if (json['gender'] != null) {
      gender = <Gender>[];
      json['gender'].forEach((v) {
        gender!.add(new Gender.fromJson(v));
      });
    }
    if (json['age'] != null) {
      age = <Age>[];
      json['age'].forEach((v) {
        age!.add(new Age.fromJson(v));
      });
    }
    if (json['breed origin'] != null) {
      breedOrigin = <BreedOrigin>[];
      json['breed origin'].forEach((v) {
        breedOrigin!.add(new BreedOrigin.fromJson(v));
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
    if (this.type != null) {
      data['type'] = this.type!.map((v) => v.toJson()).toList();
    }
    if (this.gender != null) {
      data['gender'] = this.gender!.map((v) => v.toJson()).toList();
    }
    if (this.age != null) {
      data['age'] = this.age!.map((v) => v.toJson()).toList();
    }
    if (this.breedOrigin != null) {
      data['breed origin'] = this.breedOrigin!.map((v) => v.toJson()).toList();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Type {
  String? typeId;
  String? typeName;

  Type({this.typeId, this.typeName});

  Type.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    return data;
  }
}

class Gender {
  String? genderId;
  String? genderName;

  Gender({this.genderId, this.genderName});

  Gender.fromJson(Map<String, dynamic> json) {
    genderId = json['gender_id'];
    genderName = json['gender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender_id'] = this.genderId;
    data['gender_name'] = this.genderName;
    return data;
  }
}

class Age {
  String? ageId;
  String? ageName;

  Age({this.ageId, this.ageName});

  Age.fromJson(Map<String, dynamic> json) {
    ageId = json['age_id'];
    ageName = json['age_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age_id'] = this.ageId;
    data['age_name'] = this.ageName;
    return data;
  }
}

class BreedOrigin {
  String? breedId;
  String? breedName;

  BreedOrigin({this.breedId, this.breedName});

  BreedOrigin.fromJson(Map<String, dynamic> json) {
    breedId = json['breed_id'];
    breedName = json['breed_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breed_id'] = this.breedId;
    data['breed_name'] = this.breedName;
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
    governorateId = json['governorate_id'];
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
    stateId = json['state_id'];
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
    cityId = json['city_id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    return data;
  }
}
