import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/ordered_model.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PlacedOrdersController extends SuperController<List<OrderedItem>> {
  PlacedOrdersController({this.homeRepository});

  final HomeRepository homeRepository;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getOrderedList);
  }

  @override
  void onReady() {
    print('The build method is done. '
        'Your controller is ready to call dialogs and snackbars');
    super.onReady();
  }

  void clearAllOrders() {
    box.remove(ORDERED_KEY);

    append(() => homeRepository.getOrderedList);
  }

  void goToPlacedOrdersDetail(String orderId) {
    Get.toNamed('/home/profile/placedorders/placeorderdetail?id=${orderId}');
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
