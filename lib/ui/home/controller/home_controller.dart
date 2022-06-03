import 'dart:convert';

import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/cart_model.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends SuperController<List<CartModel>> {
  HomeController({this.homeRepository});

  final HomeRepository homeRepository;

  final currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
    update();
  }

  int getTabIndex() => currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getCartList);

    GetStorage().listenKey(CART_KEY, (value) {
      append(() => homeRepository.getCartList);
    });
  }

  List<CartModel> getCartList() {
    if (readList(CART_KEY) != null) {
      final data = jsonDecode(readList(CART_KEY)) as List<dynamic>;
      return data.map((e) => CartModel.fromJson(e)).toList();
    } else {
      return List.empty();
    }
  }

  void goToNotificationList() {
    Get.toNamed('/home/notification');
  }

  void goToCartList() {
    Get.toNamed('/home/cart');
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
