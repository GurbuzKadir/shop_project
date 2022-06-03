import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:get/get.dart';

class ProductListController extends SuperController<List<DataProduct>> {
  ProductListController({this.homeRepository});

  final HomeRepository homeRepository;

  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getAllProductList);
  }

  void getProductListByType(int type) {
    if (type > 0) {
      homeRepository.getProductByType(type).then((value) {
        state.clear();
        state.addAll(value);
      }).onError((error, stackTrace) {
        state.clear();
        state.addAll(List.empty());
      });
    }
  }

  void getProductListByCategory(int category) {
    if (category > 0) {
      homeRepository.getProductListByCategory(category).then((value) {
        state.clear();
        state.addAll(value);
      }).onError((error, stackTrace) {
        state.clear();
        state.addAll(List.empty());
      });
    }
  }

  void goToProductDetail({int index}) {
    Get.toNamed('/home/category/productlist/productdetail?id=$index');
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
