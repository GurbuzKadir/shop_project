import 'package:eshop/domain/models/product_model.dart';

class FlashSale {
  bool isActive;
  String eventTitle;
  String image;
  String eventDuration;
  List<DataProduct> productList;

  FlashSale(
      {this.isActive,
      this.eventTitle,
      this.image,
      this.eventDuration,
      this.productList});

  FlashSale.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'] ?? false;
    eventTitle = json['eventTitle'];
    image = json['image'];
    eventDuration = json['event_duration'];
    if (json['product_list'] != null) {
      productList = <DataProduct>[];
      json['product_list'].forEach((v) {
        productList.add(new DataProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['eventTitle'] = this.eventTitle;
    data['image'] = this.image;
    data['event_duration'] = this.eventDuration;
    if (this.productList != null) {
      data['product_list'] = this.productList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
