class GetStoreOngoingModel {
  List<GetStoreOngoingResult>? result;
  String? message;
  String? status;

  GetStoreOngoingModel({this.result, this.message, this.status});

  GetStoreOngoingModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GetStoreOngoingResult>[];
      json['result'].forEach((v) {
        result!.add(new GetStoreOngoingResult.fromJson(v));
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

class GetStoreOngoingResult {
  String? id;
  String? userId;
  String? productId;
  String? amount;
  String? orderDate;
  String? orderTime;
  String? cartId;
  String? dateTime;
  String? storeId;
  String? paymentType;
  String? status;
  String? reason;
  List<ProductDetails>? productDetails;

  GetStoreOngoingResult(
      {this.id,
        this.userId,
        this.productId,
        this.amount,
        this.orderDate,
        this.orderTime,
        this.cartId,
        this.dateTime,
        this.storeId,
        this.paymentType,
        this.status,
        this.reason,
        this.productDetails});

  GetStoreOngoingResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    amount = json['amount'];
    orderDate = json['order_date'];
    orderTime = json['order_time'];
    cartId = json['cart_id'];
    dateTime = json['date_time'];
    storeId = json['store_id'];
    paymentType = json['payment_type'];
    status = json['status'];
    reason = json['reason'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['amount'] = this.amount;
    data['order_date'] = this.orderDate;
    data['order_time'] = this.orderTime;
    data['cart_id'] = this.cartId;
    data['date_time'] = this.dateTime;
    data['store_id'] = this.storeId;
    data['payment_type'] = this.paymentType;
    data['status'] = this.status;
    data['reason'] = this.reason;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  String? productName;
  String? productPrice;
  String? categoryId;
  String? description;
  String? stock;
  String? dateTime;
  String? productSize;
  String? productColor;
  String? userId;
  String? type;
  String? quantity;
  String? productImage;
  String? storeName;
  String? userName;
  String? mobile;
  String? image;

  ProductDetails(
      {this.productName,
        this.productPrice,
        this.categoryId,
        this.description,
        this.stock,
        this.dateTime,
        this.productSize,
        this.productColor,
        this.userId,
        this.type,
        this.quantity,
        this.productImage,
        this.storeName,
        this.userName,
        this.mobile,
        this.image});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    categoryId = json['category_id'];
    description = json['description'];
    stock = json['stock'];
    dateTime = json['date_time'];
    productSize = json['product_size'];
    productColor = json['product_color'];
    userId = json['user_id'];
    type = json['type'];
    quantity = json['quantity'];
    productImage = json['product_image'];
    storeName = json['store_name'];
    userName = json['user_name'];
    mobile = json['mobile'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['date_time'] = this.dateTime;
    data['product_size'] = this.productSize;
    data['product_color'] = this.productColor;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    data['product_image'] = this.productImage;
    data['store_name'] = this.storeName;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    return data;
  }
}
