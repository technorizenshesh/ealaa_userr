class PhoneOperatorModel {
  PhoneOperatorResult? result;
  String? message;
  String? status;

  PhoneOperatorModel({this.result, this.message, this.status});

  PhoneOperatorModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new PhoneOperatorResult.fromJson(json['result']) : null;
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

class PhoneOperatorResult {
  List<Operators>? operators;
  List<Governorate>? governorate;

  PhoneOperatorResult({this.operators, this.governorate});

  PhoneOperatorResult.fromJson(Map<String, dynamic> json) {
    if (json['operators'] != null) {
      operators = <Operators>[];
      json['operators'].forEach((v) {
        operators!.add(new Operators.fromJson(v));
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
    if (this.operators != null) {
      data['operators'] = this.operators!.map((v) => v.toJson()).toList();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Operators {
  String? operatorsId;
  String? operatorsName;

  Operators({this.operatorsId, this.operatorsName});

  Operators.fromJson(Map<String, dynamic> json) {
    operatorsId = json['operators_id'];
    operatorsName = json['operators_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operators_id'] = this.operatorsId;
    data['operators_name'] = this.operatorsName;
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
