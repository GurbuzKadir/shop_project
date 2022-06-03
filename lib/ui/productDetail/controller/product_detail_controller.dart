import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/cart_model.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:get/get.dart';

class ProductDetailController extends SuperController<List<DataProduct>> {
  ProductDetailController({this.homeRepository});

  final HomeRepository homeRepository;

  final currentCount = 1.obs;

  void changeCount(int count) {
    currentCount.value = count;
    update();
  }

  int getCount() => currentCount.value;

  final currentIndex = 0.obs;

  void changeImageIndex(int index) {
    currentIndex.value = index;
    update();
  }

  int getImageIndex() => currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getAllProductList);
  }

  DataProduct getProductDetail(String id) {
    final index = int.tryParse(id);
    return state.where((element) => element.id == index)?.first ?? state.first;
  }

  String getDiscountPrice(String id) {
    final index = int.tryParse(id);
    DataProduct product =
        state.where((element) => element.id == index).first ?? state.first;

    if (product.discountPercent.isBlank || product.discountPercent.isEqual(0)) {
      return product.price;
    } else {
      final totalPrice = int.parse(product.price) -
          getDiscountAmount(int.parse(product.price), product.discountPercent);

      return totalPrice.toString();
    }
  }

  void goToProductDetail({int index}) {
    Get.toNamed(
      '/home/category/productlist/productdetail?id=$index',
    );
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
    currentIndex.value = 0;
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
