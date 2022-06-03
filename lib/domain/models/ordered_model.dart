import 'package:eshop/domain/models/cart_model.dart';

class OrderedItem {
  String id;
  List<CartModel> cartModel;
  String totalPrice;
  String placedTime;
  String address;
  String contactNumber;
  String estimateDeliveryDate;
  String subTotal;
  String discount;
  String estimateVat;

  OrderedItem(
      {this.id,
      this.cartModel,
      this.totalPrice,
      this.placedTime,
      this.address,
      this.contactNumber,
      this.estimateDeliveryDate,
      this.subTotal,
      this.discount,
      this.estimateVat});

  OrderedItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['card_model'] != null) {
      cartModel = <CartModel>[];
      json['card_model'].forEach((v) {
        cartModel.add(new CartModel.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
    placedTime = json['placed_time'];
    address = json['address'];
    contactNumber = json['contact_number'];
    estimateDeliveryDate = json['estimate_delivery_date'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    estimateVat = json['estimate_vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cartModel != null) {
      data['card_model'] = this.cartModel.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['placed_time'] = this.placedTime;
    data['address'] = this.address;
    data['contact_number'] = this.contactNumber;
    data['estimate_delivery_date'] = this.estimateDeliveryDate;
    data['sub_total'] = this.subTotal;
    data['discount'] = this.discount;
    data['estimate_vat'] = this.estimateVat;
    return data;
  }
}
