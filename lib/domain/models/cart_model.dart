class CartModel {
  int productId;
  int count;
  int status = 0;

  /// 0 for cart data and 1 for ordered data <- I know need to thought about Ordered, Processing, Packed, Shipped, Delivered and etc. but I dun have enough time about it. Deadline is coming.... xD just kidding */

  CartModel({this.productId, this.count, this.status});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    count = json['count'];
    status = json['status'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}
