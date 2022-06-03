import 'package:eshop/domain/models/home_data.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:get/get.dart';

class ShopController extends SuperController<HomeData> {
  ShopController({this.homeRepository});

  final HomeRepository homeRepository;

  final selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  int getTabIndex() => selectedIndex.value;

  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getHomeData);
  }

  ///GetX prevent accidental push to screen twice.
  ///Use "preventDuplicates:false" to avoid this behaviour <= this is happening on 5.0 beta version just fixed by stable version updated.
  void goToProductList({int index, int type, String title}) {
    Get.toNamed(
        '/home/shop/productlist?type=$type&categoryId=$index&title=$title');
  }

  void goToProductDetail({int index}) {
    Get.toNamed('/home/shop/productdetail?id=$index');
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
