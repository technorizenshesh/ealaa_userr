class RealStateUseModel {
  RealStateUseResult? result;
  String? message;
  String? status;

  RealStateUseModel({this.result, this.message, this.status});

  RealStateUseModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new RealStateUseResult.fromJson(json['result']) : null;
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

class RealStateUseResult {
  List<UseList>? use;
  List<WallList>? Wall;
  List<Landtype>? landtype;
  List<PositionList>? position;
  List<Parking>? parking;
  List<Governorate>? governorate;

  RealStateUseResult(
      {this.use,
        this.Wall,
        this.landtype,
        this.position,
        this.parking,
        this.governorate});

  RealStateUseResult.fromJson(Map<String, dynamic> json) {
    if (json['use'] != null) {
      use = <UseList>[];
      json['use'].forEach((v) {
        use!.add(new UseList.fromJson(v));
      });
    }
    if (json['wall'] != null) {
      Wall = <WallList>[];
      json['wall'].forEach((v) {
        Wall!.add(new WallList.fromJson(v));
      });
    }
    if (json['landtype'] != null) {
      landtype = <Landtype>[];
      json['landtype'].forEach((v) {
        landtype!.add(new Landtype.fromJson(v));
      });
    }
    if (json['position'] != null) {
      position = <PositionList>[];
      json['position'].forEach((v) {
        position!.add(new PositionList.fromJson(v));
      });
    }
    if (json['parking'] != null) {
      parking = <Parking>[];
      json['parking'].forEach((v) {
        parking!.add(new Parking.fromJson(v));
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
    if (this.use != null) {
      data['use'] = this.use!.map((v) => v.toJson()).toList();
    }
    if (this.Wall != null) {
      data['Wall'] = this.Wall!.map((v) => v.toJson()).toList();
    }
    if (this.landtype != null) {
      data['landtype'] = this.landtype!.map((v) => v.toJson()).toList();
    }
    if (this.position != null) {
      data['position'] = this.position!.map((v) => v.toJson()).toList();
    }
    if (this.parking != null) {
      data['parking'] = this.parking!.map((v) => v.toJson()).toList();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UseList {
  String? useId;
  String? useName;

  UseList({this.useId, this.useName});

  UseList.fromJson(Map<String, dynamic> json) {
    useId = json['use_id'];
    useName = json['use_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['use_id'] = this.useId;
    data['use_name'] = this.useName;
    return data;
  }
}

class WallList {
  String? WallId;
  String? WallName;

  WallList({this.WallId, this.WallName});

  WallList.fromJson(Map<String, dynamic> json) {
    WallId = json['wall_id'];
    WallName = json['wall_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Wall_id'] = this.WallId;
    data['Wall_name'] = this.WallName;
    return data;
  }
}

class Landtype {
  String? landtypeId;
  String? landtypeName;

  Landtype({this.landtypeId, this.landtypeName});

  Landtype.fromJson(Map<String, dynamic> json) {
    landtypeId = json['landtype_id'];
    landtypeName = json['landtype_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['landtype_id'] = this.landtypeId;
    data['landtype_name'] = this.landtypeName;
    return data;
  }
}

class PositionList {
  String? positionId;
  String? positionName;

  PositionList({this.positionId, this.positionName});

  PositionList.fromJson(Map<String, dynamic> json) {
    positionId = json['position_id'];
    positionName = json['position_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position_id'] = this.positionId;
    data['position_name'] = this.positionName;
    return data;
  }
}

class Parking {
  String? parkingId;
  String? parkingName;

  Parking({this.parkingId, this.parkingName});

  Parking.fromJson(Map<String, dynamic> json) {
    parkingId = json['parking_id'];
    parkingName = json['parking_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parking_id'] = this.parkingId;
    data['parking_name'] = this.parkingName;
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
