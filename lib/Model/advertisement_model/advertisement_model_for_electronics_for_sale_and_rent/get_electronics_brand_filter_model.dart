class GetElectronicsBrandFilterModel {
  List<GetElectronicsBrandFilterResult>? result;
  String? message;
  String? status;

  GetElectronicsBrandFilterModel({this.result, this.message, this.status});

  GetElectronicsBrandFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetElectronicsBrandFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetElectronicsBrandFilterResult.fromJson(v));
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

class GetElectronicsBrandFilterResult {
  String? brandId;
  String? name;

  GetElectronicsBrandFilterResult({this.brandId, this.name});

  GetElectronicsBrandFilterResult.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    return data;
  }
}
