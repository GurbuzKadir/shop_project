import 'dart:convert';

import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/address_model.dart';
import 'package:eshop/domain/models/cart_model.dart';
import 'package:eshop/domain/models/ordered_model.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AddressController extends SuperController<List<DataProduct>> {
  AddressController({this.homeRepository});

  final HomeRepository homeRepository;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getAllProductList);
  }

  List<AddressModel> getAddressList() {
    if (readList(ADDRESS_KEY) != null) {
      final data = jsonDecode(readList(ADDRESS_KEY)) as List<dynamic>;
      return data.map((e) => AddressModel.fromJson(e)).toList();
    } else {
      return List.empty();
    }
  }

  void clearAllAddress() {
    box.remove(ADDRESS_KEY);
  }

  AddressModel getAddressData(
      {String name,
      String phone,
      String email,
      String address,
      String city,
      String country,
      String postalCode}) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final model = AddressModel(
        id: timestamp,
        name: name,
        phoneNumber: phone,
        email: email ?? "",
        address: address,
        city: city,
        country: country,
        postalCode: postalCode);

    return model;
  }

  void addAddressContent(AddressModel model) {
    List<AddressModel> list = [];
    list.add(model);

    saveList(ADDRESS_KEY, list);
  }

  void clearAllCart() {
    box.remove(CART_KEY);
  }

  OrderedItem getOrderedData(
      {List<CartModel> cartModel,
      String totalPrice,
      String placedTime,
      String address,
      String contactNumber,
      String estimateDeliveryDate,
      String subTotal,
      String discount,
      String estimateVat}) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    return OrderedItem(
        id: timestamp.toString(),
        cartModel: cartModel,
        totalPrice: totalPrice,
        placedTime: placedTime,
        address: address,
        contactNumber: contactNumber,
        estimateDeliveryDate: estimateDeliveryDate,
        subTotal: subTotal,
        discount: discount,
        estimateVat: estimateVat);
  }

  void addOrderedContent(OrderedItem model) {
    List<OrderedItem> list = [];
    list.add(model);

    saveList(ORDERED_KEY, list);
  }

  void goToOrdersList() {
    Get.toNamed('/home/profile/placedorders');
  }

  DataProduct getProductDetail(String id) {
    final index = int.tryParse(id);
    return state.where((element) => element.id == index)?.first ?? state.first;
  }

  String getEstimateDeliveryDate() {
    var today = new DateTime.now();
    var tenDaysFromNow = today.add(new Duration(days: 10));
    var fiftyDaysFromNow = today.add(new Duration(days: 15));

    var tenDays = DateFormat("dd MMM yyyy").format(tenDaysFromNow);
    var fiftyDays = DateFormat("dd MMM yyyy").format(fiftyDaysFromNow);

    return tenDays + " - " + fiftyDays;
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
        : "$couponCode is not activate.";
  }

  List<CartModel> getCartList() {
    if (readList(CART_KEY) != null) {
      final data = jsonDecode(readList(CART_KEY)) as List<dynamic>;
      final cartList = data.map((e) => CartModel.fromJson(e)).toList();
      return cartList
          .where((element) => element.status == 0 && element.count > 0)
          .toList();
    } else {
      return List.empty();
    }
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
