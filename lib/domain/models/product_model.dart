import 'package:eshop/domain/models/brand_model.dart';

class DataProduct {
  int id;
  String title;
  String description;
  List<String> images;
  Brand brand;
  int category;
  String price;
  int discountPercent;
  bool favourite;
  int available;
  int type;
  String shippingInfo;
  String returnPolicy;

  DataProduct(
      {this.id,
      this.title,
      this.description,
      this.images,
      this.brand,
      this.category,
      this.price,
      this.discountPercent,
      this.favourite,
      this.available,
      this.type,
      this.shippingInfo,
      this.returnPolicy});

  DataProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    images = json['images'].cast<String>();
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    category = json['category'];
    price = json['price'];
    discountPercent = json['discountPercent'];
    favourite = json['favourite'];
    available = json['available'];
    type = json['type'];
    shippingInfo = json['shipping_info'];
    returnPolicy = json['return_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['images'] = this.images;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['category'] = this.category;
    data['price'] = this.price;
    data['discountPercent'] = this.discountPercent;
    data['favourite'] = this.favourite;
    data['available'] = this.available;
    data['type'] = this.type;
    data['shipping_info'] = this.shippingInfo;
    data['return_policy'] = this.returnPolicy;
    return data;
  }
}
