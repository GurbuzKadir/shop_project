import 'package:eshop/domain/remote/home_provider.dart';
import 'package:eshop/domain/remote/home_provider_impl.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:eshop/domain/repository/home_repository_impl.dart';
import 'package:eshop/ui/address/controller/address_controller.dart';
import 'package:eshop/ui/cart/controller/add_to_cart_controller.dart';
import 'package:eshop/ui/home/controller/home_controller.dart';
import 'package:eshop/ui/notification/controller/notification_controller.dart';
import 'package:eshop/ui/orderReturn/controller/order_return_controller.dart';
import 'package:eshop/ui/orders/controller/placed_orders_controller.dart';
import 'package:eshop/ui/placedOrderDetail/controller/placed_order_detail_controller.dart';
import 'package:eshop/ui/productDetail/controller/product_detail_controller.dart';
import 'package:eshop/ui/productlist/controller/productlist_controller.dart';
import 'package:eshop/ui/profile/controller/profile_controller.dart';
import 'package:eshop/ui/shop/controller/shop_controller.dart';
import 'package:get/get.dart';

import '../../ui/categories/controller/categories_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeProvider>(() => HomeProviderImpl());
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(provider: Get.find()));
    Get.lazyPut(() => HomeController(homeRepository: Get.find()));
    Get.lazyPut(() => ShopController(homeRepository: Get.find()));
    Get.lazyPut(() => CategoriesController(homeRepository: Get.find()));
    Get.lazyPut(() => ProductListController(homeRepository: Get.find()));
    Get.lazyPut(() => ProductDetailController(homeRepository: Get.find()));
    Get.lazyPut(() => NotificationController(homeRepository: Get.find()));
    Get.lazyPut(() => ProfileController(homeRepository: Get.find()));
    Get.lazyPut(() => AddToCartController(homeRepository: Get.find()));
    Get.lazyPut(() => AddressController(homeRepository: Get.find()));
    Get.lazyPut(() => OrderReturnController(homeRepository: Get.find()));
    Get.lazyPut(() => PlacedOrdersController(homeRepository: Get.find()));
    Get.lazyPut(() => PlacedOrderDetailController(homeRepository: Get.find()));
  }
}
