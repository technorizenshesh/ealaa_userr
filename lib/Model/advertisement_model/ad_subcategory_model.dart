class GetSubcategoryModel {
  List<SubcategoryResult>? result;
  String? count;
  String selectedCount = '0';
  String? message;
  String? status;


  GetSubcategoryModel({this.result, this.message, this.status});

  GetSubcategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <SubcategoryResult>[];
      json['result'].forEach((v) {
        result!.add(new SubcategoryResult.fromJson(v));
      });
    }
    count = json['count'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class SubcategoryResult {
  String? id;
  String? categoryId;
  String? subCategoryName;
  String? image;
  String? dateTime;
  String? subcount;
  String? selected;

  SubcategoryResult(
      {this.id,
        this.categoryId,
        this.subCategoryName,
        this.image,
        this.dateTime,
        this.subcount,});

  SubcategoryResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
    image = json['image'];
    dateTime = json['date_time'];
    subcount = json['subcount'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['image'] = this.image;
    data['date_time'] = this.dateTime;
    data['subcount'] = this.subcount;
    return data;
  }
}
