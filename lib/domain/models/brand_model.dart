class Brand {
  String name;
  String shippingFrom;
  String address;

  Brand({this.name, this.shippingFrom, this.address});

  Brand.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shippingFrom = json['shippingFrom'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['shippingFrom'] = this.shippingFrom;
    data['address'] = this.address;
    return data;
  }
}
