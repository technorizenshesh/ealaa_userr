class CityModel {
  List<CityResult> result;
  String message;
  String status;

  CityModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    result: List<CityResult>.from(json["result"].map((x) => CityResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class CityResult {
  String id;
  String name;
  String stateId;
  String countryId;
  Status status;

  CityResult({
    required this.id,
    required this.name,
    required this.stateId,
    required this.countryId,
    required this.status,
  });

  factory CityResult.fromJson(Map<String, dynamic> json) => CityResult(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    countryId: json["country_id"],
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "country_id": countryId,
    "status": statusValues.reverse[status],
  };
}

enum Status {
  ACTIVE,
  DEACTIVE
}

final statusValues = EnumValues({
  "Active": Status.ACTIVE,
  "Deactive": Status.DEACTIVE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
