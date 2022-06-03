import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:eshop/domain/models/event_sale_model.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

part 'fonts.dart';
part 'palette.dart';
part 'screen_size_reducer.dart';

const String ADDRESS_KEY = "ADDRESSKEY";
const String CART_KEY = "CARTKEY";
const String ORDERED_KEY = "ORDEREDKEY";

String getBaht() => "TL";

int getVAT() => 80;

List<String> getAvailableCoupon() => ["PROMO10", "PROMO20"];

extension E on String {
  String lastChars(int n) => substring(length - n);
}

/// write a storage key's value
saveListWithGetStorage(String storageKey, List<dynamic> storageValue) async =>
    await GetStorage().write(storageKey, jsonEncode(storageValue));

/// read from storage
readWithGetStorage(String storageKey) => GetStorage().read(storageKey);

saveList(String storeKey, List<dynamic> listNeedToSave) {
  /// getting all saved data
  String oldSavedData = readWithGetStorage(storeKey);

  /// in case there is saved data
  if (oldSavedData != null) {
    /// create a holder list for the old data
    List<dynamic> oldSavedList = jsonDecode(oldSavedData);

    /// append the new list to saved one
    oldSavedList.addAll(listNeedToSave);

    /// save the new collection
    return saveListWithGetStorage(storeKey, oldSavedList);
  } else {
    /// in case of there is no saved data -- add the new list to storage
    return saveListWithGetStorage(storeKey, listNeedToSave);
  }
}

/// read from the storage
readList(String storeKey) => readWithGetStorage(storeKey);

Widget saleEventView({BuildContext ctx, EventSaleList eventSaleList}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              eventSaleList.image ?? "https://picsum.photos/200/300?random=9",
              fit: BoxFit.cover,
              height: 150,
              width: MediaQuery.of(ctx).size.width,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 50),
                child: Column(
                  children: [
                    Text(
                      eventSaleList.title ?? "Etkinlik Satışı",
                      style: ctx.toBeba64RegularFont(Palette.colorWhite),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.navigate_next, color: Palette.colorBlack),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(8),
                  primary: Colors.white70,
                  onPrimary: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget popularProductView({BuildContext ctx, DataProduct product}) => SizedBox(
      width: 120,
      child: Card(
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        product.images[0] + product.id.toString(),
                        cacheHeight: 90,
                        cacheWidth: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (product.discountPercent != 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.colorDeepOrangeAccent),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.discountPercent.toString() + "%" ?? "0%",
                            style: ctx.toPop8RegularFont(Palette.colorWhite),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
                SizedBox(
                  height: 4,
                ),
                Text(
                  product.brand.name ?? "Firma Adı",
                  style: ctx.toPop8SemiBoldFont(Palette.colorGrey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.title ?? "Yaz İndirimi Özel İndirim Fırsatı",
                  style: ctx.toPop10RegularFont(Palette.colorBlack),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: " TL ${getDiscountPrice(product)}",
                          style: ctx.toPop10SemiBoldFont(Palette.colorBlack)),
                      ((product.discountPercent != 0)
                          ? TextSpan(
                              text: " TL ${product.price}",
                              style: ctx
                                  .toPop8RegularFont(
                                      Palette.colorDeepOrangeAccent)
                                  .copyWith(
                                      decoration: TextDecoration.lineThrough))
                          : TextSpan()),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );

String getDiscountPrice(DataProduct product) {
  if (product.discountPercent.isBlank || product.discountPercent.isEqual(0)) {
    return product.price;
  } else {
    final totalPrice = int.parse(product.price) -
        getDiscountAmount(int.parse(product.price), product.discountPercent);

    return totalPrice.toString();
  }
}

getDiscountAmount(int price, int percent) => price * percent / 100;
