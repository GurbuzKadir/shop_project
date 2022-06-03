import 'dart:convert';
import 'dart:io';

import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/address_model.dart';
import 'package:eshop/domain/models/brand_model.dart';
import 'package:eshop/domain/models/carousel_images_model.dart';
import 'package:eshop/domain/models/cart_model.dart';
import 'package:eshop/domain/models/categories_model.dart';
import 'package:eshop/domain/models/event_sale_model.dart';
import 'package:eshop/domain/models/flash_sale_model.dart';
import 'package:eshop/domain/models/home_data.dart';
import 'package:eshop/domain/models/notification_model.dart';
import 'package:eshop/domain/models/ordered_model.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/domain/repository/home_repository.dart';
import 'package:eshop/ui/productlist/controller/productlist_controller.dart';
import 'package:eshop/ui/shop/controller/shop_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:matcher/matcher.dart' as m;

Widget makeTestableWidget() => MaterialApp(home: Image.network(''));

class MockRepositorySuccess implements HomeRepository {
  @override
  Future<List<AddressModel>> getAddressList() {
    // TODO: implement getAddressList
    throw UnimplementedError();
  }

  @override
  Future<List<DataProduct>> getAllProductList() async {
    final file = new File('test_resources/sampleProduct.json');
    return (jsonDecode(await file.readAsString()) as List<dynamic>)
        .map((e) => DataProduct.fromJson(e))
        .toList();
  }

  @override
  Future<List<CartModel>> getCartList() {
    // TODO: implement getCartList
    throw UnimplementedError();
  }

  @override
  Future<List<DataProduct>> getDiscountProductList() {
    // TODO: implement getDiscountProductList
    throw UnimplementedError();
  }

  @override
  Future<HomeData> getHomeData() async {
    return HomeData(
        carouselImages: _getMockCarouselImageList(),
        categories: _getMockCategoriesList(),
        popularProduct: [_getMockProduct()],
        bestSeller: [_getMockProduct()],
        flashSale: _getMockFlashSale(),
        eventSale: _getMockEventSale());
  }

  _getMockEventSale() => EventSale(
      isActive: true,
      image: "",
      eventTitle: "Event sale title",
      eventSaleList: []);

  _getMockFlashSale() => FlashSale(
      productList: [_getMockProduct()],
      eventDuration: "10000",
      eventTitle: "Flash sale event title",
      image: "",
      isActive: true);

  _getMockCarouselImageList() => [
        CarouselImages(
            id: 1,
            imageUrl: "https://picsum.photos/200/300",
            title: "Carousel One",
            type: 1),
        CarouselImages(
            id: 2,
            imageUrl: "https://picsum.photos/id/237/200/300",
            title: "Carousel Two",
            type: 1),
      ];

  _getMockCategoriesList() => [
        Categories(
            id: 1,
            name: "Category title",
            icon: "https://picsum.photos/id/237/200/300"),
        Categories(
            id: 2,
            name: "Category Two title",
            icon: "https://picsum.photos/id/237/200/300"),
      ];

  _getMockProduct() => DataProduct(
      id: 1001,
      title: "Item One Popular Product",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      images: [],
      brand: Brand(
        name: "Brand Name",
        address: "Brand company address or shop address",
        shippingFrom: "Turkey",
      ),
      category: 1,
      price: "3500",
      discountPercent: 20,
      favourite: false,
      available: 1,
      type: 1,
      shippingInfo:
          "STANDART NAKLİYE 20 TL. 120TL civarındaki siparişlerde ÜCRETSİZ. 1-2 haftada teslim edilmesi tahmin edilmektedir",
      returnPolicy: "https://www.mevzuat.gov.tr/mevzuatmetin/1.5.6563.pdf");

  @override
  Future<List<NotificationModel>> getNotificationList() {
    // TODO: implement getNotificationList
    throw UnimplementedError();
  }

  @override
  Future<List<OrderedItem>> getOrderedList() {
    // TODO: implement getOrderedList
    throw UnimplementedError();
  }

  @override
  Future<List<DataProduct>> getProductByType(int type) {
    // TODO: implement getProductByType
    throw UnimplementedError();
  }

  @override
  Future<DataProduct> getProductDetail(int productId) {
    // TODO: implement getProductDetail
    throw UnimplementedError();
  }

  @override
  Future<List<DataProduct>> getProductListByCategory(int category) {
    // TODO: implement getProductListByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<DataProduct>> getRandomProductList() {
    // TODO: implement getRandomProductList
    throw UnimplementedError();
  }

  @override
  Future<String> getProductCategoryName(int categoryId) {
    // TODO: implement getProductCategoryName
    throw UnimplementedError();
  }

  @override
  Future<String> getProductTypeName(int typeId) {
    // TODO: implement getProductTypeName
    throw UnimplementedError();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  final binding = BindingsBuilder(() {
    Get.lazyPut<HomeRepository>(() => MockRepositorySuccess());
    Get.lazyPut(() => ShopController(homeRepository: Get.find()));
    Get.lazyPut(() => ProductListController(homeRepository: Get.find()));
  });

  test('Load a json file', () async {
    final file = new File('test_resources/sampleProduct.json');
    final json = jsonDecode(await file.readAsString()) as List<dynamic>;
    final productList = json.map((e) => DataProduct.fromJson(e)).toList();

    expect(productList.isEmpty, false);
    expect(productList.length, 2);
  });

  test('Test Dependencies Binding', () {
    expect(Get.isPrepared<ProductListController>(), false);
    expect(Get.isPrepared<ShopController>(), false);
    expect(Get.isPrepared<HomeRepository>(), false);

    /// test you Binding class with BindingsBuilder
    binding.builder();

    expect(Get.isPrepared<ProductListController>(), true);
    expect(Get.isPrepared<ShopController>(), true);
    expect(Get.isPrepared<HomeRepository>(), true);

    Get.reset();
  });

  test('Test Shop Controller', () async {
    /// Controller can't be on memory
    expect(() => Get.find<ShopController>(tag: 'success'),
        throwsA(m.TypeMatcher<String>()));

    /// binding will put the controller on memory
    binding.builder();

    /// recover controller
    final controller = Get.find<ShopController>();

    /// check if onInit was called
    expect(controller.initialized, true);

    /// check initial Status
    expect(controller.status.isLoading, true);

    /// await time request
    await Future.delayed(Duration(milliseconds: 100));

    /// test if status is success
    expect(controller.status.isSuccess, true);
    expect(controller.state.carouselImages.length, 2);
    expect(controller.state.popularProduct.length, 1);
  });

  test('Test Product List Controller', () async {
    /// Controller can't be on memory
    expect(() => Get.find<ProductListController>(tag: 'success'),
        throwsA(m.TypeMatcher<String>()));

    /// binding will put the controller on memory
    binding.builder();

    /// recover controller
    final controller = Get.find<ProductListController>();

    /// check if onInit was called
    expect(controller.initialized, true);

    /// check initial Status
    expect(controller.status.isLoading, true);

    /// await time request
    await Future.delayed(Duration(milliseconds: 100));

    /// test if status is success
    expect(controller.status.isSuccess, true);
  });

  /*getTest(
    "Home page navigation test",
    getPages: AppPages.routes,
    initialRoute: AppPages.INITIAL,
    widgetTest: (tester) async {
      expect('/home', Get.currentRoute);

      Get.toNamed('/home/shop');
      expect('/home/shop', Get.currentRoute);

      Get.toNamed('/home/category');
      expect('/home/category', Get.currentRoute);

      Get.toNamed('/home/profile');
      expect('/home/profile', Get.currentRoute);

      Get.toNamed('/home/notification');
      expect('/home/notification', Get.currentRoute);

      Get.back();

      Get.toNamed('/home/category');
      expect('/home/category', Get.currentRoute);

      Get.toNamed('/home/productlist');
      expect('/home/productlist', Get.currentRoute);

      Get.back();

      expect('/home/category', Get.currentRoute);
    },
  );*/
}
