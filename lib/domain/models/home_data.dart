import 'package:eshop/domain/models/carousel_images_model.dart';
import 'package:eshop/domain/models/categories_model.dart';
import 'package:eshop/domain/models/event_sale_model.dart';
import 'package:eshop/domain/models/flash_sale_model.dart';
import 'package:eshop/domain/models/product_model.dart';

class HomePageData {
  HomeData data;

  HomePageData({this.data});

  HomePageData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class HomeData {
  List<CarouselImages> carouselImages;
  List<Categories> categories;
  List<DataProduct> popularProduct;
  List<DataProduct> bestSeller;
  FlashSale flashSale;
  EventSale eventSale;

  HomeData(
      {this.carouselImages,
      this.categories,
      this.popularProduct,
      this.bestSeller,
      this.flashSale,
      this.eventSale});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['carousel_images'] != null) {
      carouselImages = <CarouselImages>[];
      json['carousel_images'].forEach((v) {
        carouselImages.add(new CarouselImages.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['popular_product'] != null) {
      popularProduct = <DataProduct>[];
      json['popular_product'].forEach((v) {
        popularProduct.add(new DataProduct.fromJson(v));
      });
    }
    if (json['best_seller'] != null) {
      bestSeller = <DataProduct>[];
      json['best_seller'].forEach((v) {
        bestSeller.add(new DataProduct.fromJson(v));
      });
    }
    flashSale = json['flash_sale'] != null
        ? new FlashSale.fromJson(json['flash_sale'])
        : null;
    eventSale = json['event_sale'] != null
        ? new EventSale.fromJson(json['event_sale'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carouselImages != null) {
      data['carousel_images'] =
          this.carouselImages.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.popularProduct != null) {
      data['popular_product'] =
          this.popularProduct.map((v) => v.toJson()).toList();
    }
    if (this.bestSeller != null) {
      data['best_seller'] = this.bestSeller.map((v) => v.toJson()).toList();
    }
    if (this.flashSale != null) {
      data['flash_sale'] = this.flashSale.toJson();
    }
    if (this.eventSale != null) {
      data['event_sale'] = this.eventSale.toJson();
    }
    return data;
  }
}
