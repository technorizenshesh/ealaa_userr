class GetYearFilterModel {
  List<GetYearFilterResult>? result;
  String? message;
  String? status;

  GetYearFilterModel({this.result, this.message, this.status});

  GetYearFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetYearFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetYearFilterResult.fromJson(v));
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

class GetYearFilterResult {
  String? id;
  String? year;

  GetYearFilterResult({this.id, this.year});

  GetYearFilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    return data;
  }
}
