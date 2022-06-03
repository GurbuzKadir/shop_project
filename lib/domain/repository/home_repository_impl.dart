import 'dart:convert';

import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/address_model.dart';
import 'package:eshop/domain/models/cart_model.dart';
import 'package:eshop/domain/models/home_data.dart';
import 'package:eshop/domain/models/notification_model.dart';
import 'package:eshop/domain/models/ordered_model.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/domain/remote/home_provider.dart';
import 'package:eshop/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({this.provider});

  final HomeProvider provider;

  @override
  Future<List<AddressModel>> getAddressList() async {
    final addressList = await provider.getAddressList();

    if (addressList == null || addressList.isEmpty) {
      return List.empty();
    } else {
      return addressList;
    }
  }

  @override
  Future<List<NotificationModel>> getNotificationList() async {
    final notificationList = await provider.getNotificationList();
    if (notificationList.isEmpty) {
      return Future.error("Yanıt: Boş bildirim listesi");
    } else {
      return notificationList;
    }
  }

  @override
  Future<DataProduct> getProductDetail(int productId) async {
    final productList = await provider.getAllProductList();
    if (productList.isEmpty) {
      return Future.error("Cevap : Boş ürün Detayı");
    } else {
      return productId != null ? productList[productId] : productList.first;
    }
  }

  @override
  Future<List<DataProduct>> getProductByType(int type) async {
    final productList = await provider.getProductByType(type);
    if (productList.isEmpty) {
      return Future.error("Cevap : Boş ürün listesi");
    } else {
      return productList;
    }
  }

  @override
  Future<List<DataProduct>> getAllProductList() async {
    final productList = await provider.getAllProductList();
    if (productList.isEmpty) {
      return Future.error("Cevap : Boş ürün listesi");
    } else {
      return productList;
    }
  }

  @override
  Future<List<DataProduct>> getDiscountProductList() {
    // TODO: implement getDiscountProductList
    throw UnimplementedError();
  }

  @override
  Future<List<DataProduct>> getProductListByCategory(int category) async {
    final productList = await provider.getProductListByCategory(category);
    if (productList.isEmpty) {
      return Future.error("Cevap : Boş ürün listesi");
    } else {
      return productList;
    }
  }

  @override
  Future<List<DataProduct>> getRandomProductList() {
    // TODO: implement getRandomProductList
    throw UnimplementedError();
  }

  @override
  Future<HomeData> getHomeData() async {
    final homeData = await provider.getHomeData();
    if (homeData.data == null) {
      return Future.error("Yanıt : Boş Ev Verisi");
    } else {
      return homeData.data;
    }
  }

  @override
  Future<List<CartModel>> getCartList() {
    if (readList(CART_KEY) != null) {
      final data = jsonDecode(readList(CART_KEY)) as List<dynamic>;
      final cartList = data.map((e) => CartModel.fromJson(e)).toList();
      return Future.value(
          cartList.where((element) => element.status == 0).toList());
    } else {
      return Future.value(List.empty());
    }
  }

  @override
  Future<List<OrderedItem>> getOrderedList() {
    if (readList(ORDERED_KEY) != null) {
      final data = jsonDecode(readList(ORDERED_KEY)) as List<dynamic>;
      return Future.value(data.map((e) => OrderedItem.fromJson(e)).toList());
    } else {
      return Future.value(List.empty());
    }
  }

  @override
  Future<String> getProductCategoryName(int categoryId) async {
    final name = await provider.getProductCategoryName(categoryId);
    if (name.isEmpty) {
      return Future.error("Tanımsız kategori adı");
    } else {
      return name;
    }
  }

  @override
  Future<String> getProductTypeName(int typeId) async {
    final name = await provider.getProductTypeName(typeId);
    if (name.isEmpty) {
      return Future.error("Tanımsız etkinlik adı");
    } else {
      return name;
    }
  }
}
