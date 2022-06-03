import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/flash_sale_model.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/ui/shop/controller/shop_controller.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'package:get/get.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

/*List<String> imgList = [
  'https://loremflickr.com/320/240/paris,fashion/all',
  'https://loremflickr.com/320/240/paris,dress/all',
  'https://loremflickr.com/320/240/jacket/all',
  'https://loremflickr.com/320/240/swimwear/all',
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];*/

class ShopScreen extends GetView<ShopController> {
  final CarouselController _controller = CarouselController();

  final String title;

  ShopScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: controller.obx(
        (state) => (state.carouselImages == null ||
                state.carouselImages.isBlank)
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset('assets/images/servererror.png')),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Oops, Bir sorunumuz var gibi görünüyor.",
                        style: context
                            .toPop28RegularFont(Palette.colorBlack)
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lütfen daha sonra tekrar deneyiniz.",
                        style: context.toPop14RegularFont(Palette.colorGrey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "(*Geliştirici mesajı: Sadece şaka yapan uygulama sunucuya bağlanmıyor. Lütfen varlıklar klasöründeki yerel json dosyalarını kontrol edin.)",
                        style: context.toPop10RegularFont(Palette.colorRed),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: StadiumBorder(),
                          primary: Palette.colorRed,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Kahve zamanı',
                          style:
                              context.toPop18SemiBoldFont(Palette.colorWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /** Carousel Image slider view*/
                      _carouselView(ctx: context),

                      /** Carousel Image pager navigator view*/
                      _pageIndicator(ctx: context),

                      /** Categories List view with title */
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Text(
                          "Kategori",
                          style:
                              context.toPop18SemiBoldFont(Palette.colorBlack),
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildCategories(ctx: context),

                      /** Popular product List view with title */
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popüler ürünler",
                              style: context
                                  .toPop18SemiBoldFont(Palette.colorBlack),
                            ),
                            TextButton(
                              child: Text(
                                "Tümünü göster",
                                style: context
                                    .toPop14RegularFont(Palette.colorBlue),
                              ),
                              onPressed: () {
                                controller.goToProductList(
                                    index: 0,
                                    type: 1,
                                    title:
                                        "Popüler ürünler"); //1 for POPULAR PRODUCT/ Actually direct value shouldn't assigned in widget.
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      _popularProductList(
                          ctx: context, listData: state?.popularProduct),
                      //Popular product list

                      /** Flash sale UI view with list and card */
                      SizedBox(height: 16),
                      _flashSaleCard(ctx: context, flashSale: state.flashSale),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sınırlı indirim",
                              style: context
                                  .toPop18SemiBoldFont(Palette.colorBlack),
                            ),
                            TextButton(
                              child: Text(
                                "Tümünü göster",
                                style: context
                                    .toPop14RegularFont(Palette.colorBlue),
                              ),
                              onPressed: () {
                                controller.goToProductList(
                                    index: 0,
                                    type: 3,
                                    title:
                                        "Sınırlı indirim"); //3 for FLASH SALE PRODUCT/ Actually direct value shouldn't assigned in widget.
                              },
                            ),
                          ],
                        ),
                      ),
                      _popularProductList(
                          ctx: context,
                          listData: state?.flashSale?.productList),
                      //Flash sale product list

                      /** Event sale card view*/
                      SizedBox(height: 16),

                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              state?.eventSale?.eventSaleList?.length ?? 0,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  controller.goToProductList(
                                      index: 0,
                                      type: state?.eventSale
                                          ?.eventSaleList[index].type,
                                      title: state?.eventSale
                                          ?.eventSaleList[index].title);
                                },
                                child: saleEventView(
                                  ctx: context,
                                  eventSaleList:
                                      state?.eventSale?.eventSaleList[index],
                                ),
                              )),

                      /** Best seller product List view with title */
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "En çok satanlar",
                              style: context
                                  .toPop18SemiBoldFont(Palette.colorBlack),
                            ),
                            TextButton(
                              child: Text(
                                "Tümünü göster",
                                style: context
                                    .toPop14RegularFont(Palette.colorBlue),
                              ),
                              onPressed: () {
                                controller.goToProductList(
                                    index: 0,
                                    type: 6,
                                    title:
                                        "En çok satanlar"); //6 for BEST SELLER PRODUCT/ Actually direct value shouldn't assigned in widget.
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      _popularProductList(
                          listData: state.bestSeller, ctx: context),
                      //Best seller product list
                      SizedBox(height: 100),
                    ]),
              ),
      )),
    );
  }

  _getDuration(int durationSecond) => Duration(seconds: durationSecond);

  Widget _flashSaleCard({BuildContext ctx, FlashSale flashSale}) => flashSale ==
          null
      ? Container()
      : GestureDetector(
          onTap: () {
            controller.goToProductList(
                index: 0, type: 3, title: "Sınırlı indirim");
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  flashSale.image ??
                      "https://loremflickr.com/320/240?random=${Random().nextInt(10)}",
                  fit: BoxFit.cover,
                  height: 200,
                  width: MediaQuery.of(ctx).size.width,
                ),
                Align(
                  alignment: Alignment.center,
                  child: FlutterShine(
                    light: Light(intensity: 1),
                    builder: (BuildContext context, ShineShadow shineShadow) {
                      return Column(
                        children: [
                          Text(
                            flashSale.eventTitle ?? "Sınırlı indirim",
                            style: ctx.toPop32RegularFont(Palette.colorWhite),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SlideCountdownClock(
                              duration: _getDuration(
                                  int.parse(flashSale.eventDuration)),
                              slideDirection: SlideDirection.Up,
                              separator: "-",
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              separatorTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Palette.colorBlue,
                                  shape: BoxShape.circle),
                              onDone: () {
                                Get.snackbar("Merhaba", "Saat 1 de bitiyor");
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );

  /* Widget _saleEventViewList({BuildContext ctx}) => SizedBox(
    height: 300,
    child: ListView.builder(
        itemCount: imgList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: saleEventView),
  );*/

  Widget _popularProductList({BuildContext ctx, List<DataProduct> listData}) =>
      SizedBox(
        height: 170,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: listData?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  controller.goToProductDetail(index: listData[index].id);
                },
                child: popularProductView(
                    ctx: context, product: listData[index]))),
      );

  Widget _buildCategories({BuildContext ctx}) => SizedBox(
        height: 35,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: controller?.state?.categories?.length ?? 0,
          itemBuilder: _categoriesView,
        ),
      );

  Widget _categoriesView(BuildContext ctx, int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              backgroundColor: (index == 0
                  ? Palette.colorDeepOrangeAccent
                  : Palette.colorWhite)),
          onPressed: () {
            controller.goToProductList(
                index: controller.state.categories[index].id,
                type: 0,
                title: controller.state.categories[index].name);
          },
          icon: Icon(
            Icons.grid_view,
            size: 24.0,
            color: Palette.colorBlack,
          ),
          label: Text(
            controller.state.categories[index].name ?? "Başlık",
            style: ctx.toPop10RegularFont(Palette.colorBlack),
          ),
        ),
      );

  Widget _carouselView({BuildContext ctx}) => controller
              ?.state?.carouselImages ==
          null
      ? Container()
      : CarouselSlider(
          items: controller?.state?.carouselImages
              ?.map((item) => GestureDetector(
                    onTap: () {
                      controller.goToProductList(
                          index: 0, type: item.type, title: item.title);
                    },
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item.imageUrl + item.id.toString(),
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    item.title ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ))
              ?.toList(),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                controller.changeTabIndex(index);
              }),
        );

  Widget _pageIndicator({BuildContext ctx}) => controller
              ?.state?.carouselImages ==
          null
      ? Container()
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              controller?.state?.carouselImages?.asMap()?.entries?.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 4.0,
                height: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(ctx).brightness == Brightness.dark
                            ? Palette.colorWhite
                            : Palette.colorBlack)
                        .withOpacity(
                            controller.getTabIndex() == entry.key ? 0.9 : 0.4)),
              ),
            );
          })?.toList(),
        );
}
