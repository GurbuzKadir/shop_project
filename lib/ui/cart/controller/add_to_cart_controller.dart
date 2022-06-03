import 'dart:convert';

import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/cart_model.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddToCartController extends SuperController<List<DataProduct>> {
  AddToCartController({this.homeRepository});

  final HomeRepository homeRepository;
  final box = GetStorage();

  final currentCount = 0.obs;

  void changeCount(int productId, int count) {
    final data = getCartList();

    data[data.indexWhere((element) => element.productId == productId)] =
        CartModel(productId: productId, count: count);

    clearAllCart();
    saveList(CART_KEY, data);
  }

  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getAllProductList);
  }

  DataProduct getProductDetail(String id) {
    final index = int.tryParse(id);
    return state.where((element) => element.id == index)?.first ?? state.first;
  }

  void goToAddressesScreen() {
    Get.toNamed('/home/cart/addresses?tag=CART');
  }

  double getOrderSubTotal() {
    final data = getCartList();
    var sum = 0.0;

    for (var i = 0; i < data.length; i++) {
      var product = getProductDetail(data[i].productId.toString());
      var orderedPrice = int.parse(product.price) * data[i].count;
      sum += orderedPrice;
    }

    return sum;
  }

  double getOrderDiscount() {
    final data = getCartList();
    double totalDiscount = 0.0;

    for (var i = 0; i < data.length; i++) {
      var product = getProductDetail(data[i].productId.toString());
      if (product.discountPercent.isBlank ||
          product.discountPercent.isEqual(0)) {
      } else {
        var discount = getDiscountAmount(
            int.parse(product.price), product.discountPercent);
        var orderedDiscountPrice = discount * data[i].count;

        totalDiscount += orderedDiscountPrice;
      }
    }
    return totalDiscount;
  }

  double getTotalIncludeVAT() {
    double total = getOrderSubTotal() - getOrderDiscount();
    total += getVAT();

    return total;
  }

  String checkActiveCoupon(String couponCode) {
    return getAvailableCoupon().contains(couponCode)
        ? "Applied $couponCode coupon."
        : "Sorry $couponCode is not activate.";
  }

  List<CartModel> getCartList() {
    if (readList(CART_KEY) != null) {
      final data = jsonDecode(readList(CART_KEY)) as List<dynamic>;
      final cartList = data.map((e) => CartModel.fromJson(e)).toList();
      return cartList.where((element) => element.status == 0).toList();
    } else {
      return List.empty();
    }
  }

  void clearAllCart() {
    box.remove(CART_KEY);
  }

  CartModel getCartData({int productId, int count}) {
    // int timestamp = DateTime.now().millisecondsSinceEpoch;
    final model = CartModel(productId: productId, count: count, status: 0);

    return model;
  }

  void addCartContent(CartModel model) {
    List<CartModel> list = [];
    list.add(model);

    saveList(CART_KEY, list);
  }

  @override
  void onReady() {
    print('The build method is done. '
        'Your controller is ready to call dialogs and snackbars');
    super.onReady();
  }

  @override
  void onClose() {
    print('onClose called');
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    print('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    print('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  @override
  Future<bool> didPushRoute(String route) {
    print('the route $route will be open');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    print('the current route will be closed');
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    print('onDetached called');
  }

  @override
  void onInactive() {
    print('onInative called');
  }

  @override
  void onPaused() {
    print('onPaused called');
  }

  @override
  void onResumed() {
    print('onResumed called');
  }
}
