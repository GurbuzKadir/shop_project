import 'package:eshop/domain/bindings/home_binding.dart';
import 'package:eshop/ui/address/view/address_screen.dart';
import 'package:eshop/ui/cart/view/add_to_cart_screen.dart';
import 'package:eshop/ui/categories/view/categories_screen.dart';
import 'package:eshop/ui/home/view/home_screen.dart';
import 'package:eshop/ui/notification/view/notification_screen.dart';
import 'package:eshop/ui/orderReturn/view/order_return_screen.dart';
import 'package:eshop/ui/orders/view/placed_orders_screen.dart';
import 'package:eshop/ui/placedOrderDetail/view/placed_order_detail_screen.dart';
import 'package:eshop/ui/productDetail/view/product_detail_screen.dart';
import 'package:eshop/ui/productlist/view/productlist_screen.dart';
import 'package:eshop/ui/profile/view/profile_screen.dart';
import 'package:eshop/ui/shop/view/shop_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
      children: [
        GetPage(
            name: Routes.SHOP,
            page: () => ShopScreen(""),
            binding: HomeBinding(),
            children: [
              GetPage(
                  name: Routes.PRODUCTLIST,
                  page: () => ProductListScreen(),
                  binding: HomeBinding(),
                  children: [
                    GetPage(
                      name: Routes.PRODUCTDETAIL,
                      page: () => ProductDetailScreen(),
                      binding: HomeBinding(),
                    )
                  ]),
              GetPage(
                name: Routes.PRODUCTDETAIL,
                page: () => ProductDetailScreen(),
                binding: HomeBinding(),
              )
            ]),
        GetPage(
            name: Routes.CATEGORY,
            page: () => CategoriesScreen(),
            binding: HomeBinding(),
            children: [
              GetPage(
                  name: Routes.PRODUCTLIST,
                  page: () => ProductListScreen(),
                  binding: HomeBinding(),
                  children: [
                    GetPage(
                      name: Routes.PRODUCTDETAIL,
                      page: () => ProductDetailScreen(),
                      binding: HomeBinding(),
                    )
                  ])
            ]),
        GetPage(
          name: Routes.NOTIFICATION,
          page: () => NotificationScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
            name: Routes.PROFILE,
            page: () => ProfileScreen(),
            binding: HomeBinding(),
            children: [
              GetPage(
                  name: Routes.ADDRESSES,
                  page: () => AddressScreen(),
                  binding: HomeBinding()),
              GetPage(
                  name: Routes.ORDERRETURN,
                  page: () => OrderReturnScreen(),
                  binding: HomeBinding()),
              GetPage(
                  name: Routes.PLACEDORDERS,
                  page: () => PlacedOrdersScreen(),
                  binding: HomeBinding(),
                  children: [
                    GetPage(
                        name: Routes.PLACEDORDERSDETAIL,
                        page: () => PlacedOrderDetailScreen(),
                        binding: HomeBinding())
                  ])
            ]),
        GetPage(
            name: Routes.CART,
            page: () => AddToCartScreen(),
            binding: HomeBinding(),
            children: [
              GetPage(
                  name: Routes.ADDRESSES,
                  page: () => AddressScreen(),
                  binding: HomeBinding())
            ])
      ],
    ),
  ];
}
