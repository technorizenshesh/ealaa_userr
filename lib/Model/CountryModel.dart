class CountryModel {
  List<CountryResult> result;
  String message;
  String status;

  CountryModel({
    required this.result,
    required this.message,
    required this.status,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    result: List<CountryResult>.from(json["result"].map((x) => CountryResult.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class CountryResult {
  String id;
  String iso;
  String name;
  String nicename;
  String? iso3;
  String? numcode;
  String phonecode;

  CountryResult({
    required this.id,
    required this.iso,
    required this.name,
    required this.nicename,
    required this.iso3,
    required this.numcode,
    required this.phonecode,
  });

  factory CountryResult.fromJson(Map<String, dynamic> json) => CountryResult(
    id: json["id"],
    iso: json["iso"],
    name: json["name"],
    nicename: json["nicename"],
    iso3: json["iso3"],
    numcode: json["numcode"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iso": iso,
    "name": name,
    "nicename": nicename,
    "iso3": iso3,
    "numcode": numcode,
    "phonecode": phonecode,
  };
}
