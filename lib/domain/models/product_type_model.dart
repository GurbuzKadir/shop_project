import 'package:eshop/domain/models/product_model.dart';

class ProductTypeModel {
  int id;
  String name;
  String description;
  List<DataProduct> products;

  ProductTypeModel({this.id, this.name, this.description});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['product'] != null) {
      products = <DataProduct>[];
      json['product'].forEach((v) {
        products.add(new DataProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.products != null) {
      data['product'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
