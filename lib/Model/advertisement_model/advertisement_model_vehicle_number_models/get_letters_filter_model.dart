class GetLettersFilterModel {
  List<GetLettersFilterResult>? result;
  String? message;
  String? status;

  GetLettersFilterModel({this.result, this.message, this.status});

  GetLettersFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetLettersFilterResult>[];
      json['result'].forEach((v) {
        result!.add(new GetLettersFilterResult.fromJson(v));
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

class GetLettersFilterResult {
  String? letterId;
  String? letterNameEnglish;
  String? letterNameArabic;
  String? letterCreatedAt;
  String? letterUpdatedAt;
  Null? letterDeletedAt;
  String? letterAdminStatus;

  GetLettersFilterResult(
      {this.letterId,
        this.letterNameEnglish,
        this.letterNameArabic,
        this.letterCreatedAt,
        this.letterUpdatedAt,
        this.letterDeletedAt,
        this.letterAdminStatus});

  GetLettersFilterResult.fromJson(Map<String, dynamic> json) {
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
