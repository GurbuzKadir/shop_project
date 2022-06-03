import 'package:cart_stepper/cart_stepper.dart';
import 'package:eshop/common/common.dart';
import 'package:eshop/domain/models/product_model.dart';
import 'package:eshop/ui/productDetail/controller/product_detail_controller.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    final parameter = Get.parameters;
    final productId = parameter['id'] ?? '';

    return controller.obx(
      (state) => Scaffold(
        backgroundColor: Palette.colorWhite,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.bookmark_border_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productImageCard(
                  ctx: context,
                  imageList: controller.getProductDetail(productId).images),
              SizedBox(
                height: 16,
              ),
              _productImageList(
                  context: context,
                  imageList: controller.getProductDetail(productId).images),
              SizedBox(
                height: 16,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Miktar",
                  style: context
                      .toPop14RegularFont(Palette.colorBlack)
                      .copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CartStepperInt(
                      count:
                          controller.getProductDetail(productId).available == 0
                              ? 0
                              : controller.getCount(),
                      size: 32,
                      activeBackgroundColor: Colors.white,
                      activeForegroundColor: Palette.colorBlack,
                      didChangeCount: (count) {
                        if (count <=
                            controller.getProductDetail(productId).available) {
                          controller.changeCount(count);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        controller.getProductDetail(productId).available == 0
                            ? "Stoklar tükendi"
                            : controller
                                    .getProductDetail(productId)
                                    .available
                                    .toString() +
                                " adet mevcut",
                        style: context.toPop12RegularFont(
                            controller.getProductDetail(productId).available ==
                                    0
                                ? Palette.colorRed
                                : Palette.colorGrey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.getProductDetail(productId).brand.name ??
                      "Firma Adı",
                  style: context.toPop18SemiBoldFont(Palette.colorGrey),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "${controller.getProductDetail(productId).title}",
                  style: context.toPop28RegularFont(Palette.colorBlack),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Ürün bilgisi",
                  style: context
                      .toPop14RegularFont(Palette.colorBlack)
                      .copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.getProductDetail(productId).description ?? "",
                  style: context.toPop14RegularFont(Palette.colorGrey),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 24.0,
                      color: Palette.colorBlack,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Nakliye Bilgisi",
                      style: context
                          .toPop14RegularFont(Palette.colorBlack)
                          .copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.getProductDetail(productId).shippingInfo ??
                      "Teslimat Adresi",
                  style: context.toPop14RegularFont(Palette.colorGrey),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.assignment_return_outlined,
                      size: 24.0,
                      color: Palette.colorBlack,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "İade politikasi",
                      style: context
                          .toPop14RegularFont(Palette.colorBlack)
                          .copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SelectableLinkify(
                  onOpen: (link) => print("Tıklandı ${link.url}!"),
                  text: controller.getProductDetail(productId).returnPolicy ??
                      "iade politikası bağlantısı",
                  style: context.toPop14RegularFont(Palette.colorBlue),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(),

              /** You May Also Like product List view with title */
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Şunlar da hoşunuza gidebilir",
                      style: context.toPop18SemiBoldFont(Palette.colorBlack),
                    ),
                    TextButton(
                      child: Text(
                        "",
                        style: context.toPop14RegularFont(Palette.colorBlue),
                      ),
                      onPressed: () {
                        // controller.goToProductList(index: 0, type: 0);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              _popularProductList(ctx: context, productList: controller.state),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          child: Container(
              margin: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  " TL ${controller.getDiscountPrice(productId)}",
                              style: context
                                  .toPop32RegularFont(Palette.colorBlack)),
                          (controller
                                          .getProductDetail(productId)
                                          ?.discountPercent ==
                                      0 ||
                                  controller
                                          .getProductDetail(productId)
                                          ?.discountPercent ==
                                      null)
                              ? TextSpan()
                              : TextSpan(
                                  text:
                                      "  TL ${controller.getProductDetail(productId).price}",
                                  style: context
                                      .toPop14RegularFont(
                                          Palette.colorDeepOrangeAccent)
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ), // foreground
                      onPressed: () {
                        _validateAvailableProduct(int.parse(productId));
                      },
                      child: Text(
                        'Satın Al',
                        style: context.toPop18SemiBoldFont(Palette.colorWhite),
                      ),
                    ),
                  ))
                ],
              )),
        ),
      ),
    );
  }

  const ProductDetailScreen({Key key}) : super(key: key);

  void _validateAvailableProduct(int productID) {
    if (controller.getProductDetail(productID.toString()).available <= 0) {
      Get.snackbar(
          "Uyarı", "Bu ürün stokta yoktur. Lütfen daha sonra tekrar gelin.");
    } else if (controller.getCount() == 0) {
      Get.snackbar("Uyarı", "Lütfen belirli bir miktar seçin.");
    } else {
      final model = controller.getCartData(
          productId: productID, count: controller.getCount());
      controller.addCartContent(model);
      Get.snackbar("Başarılı", "Sepete başarıyla eklendi.");
    }
  }

  Widget _popularProductList(
          {BuildContext ctx, List<DataProduct> productList}) =>
      SizedBox(
        height: 170,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: productList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/home/category/productlist/productdetail?id=${productList[index].id}',
                    );
                    // controller.goToProductDetail(index: index)
                  },
                  child: popularProductView(
                      ctx: context, product: productList[index]),
                )),
      );

  Widget _productImageList({BuildContext context, List<String> imageList}) =>
      SizedBox(
        height: 50,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: imageList.length,
            itemBuilder: (context, index) =>
                _productImageView(imageList, index)),
      );

  Widget _productImageView(List<String> imageList, int index) =>
      GestureDetector(
        onTap: () => {controller.changeImageIndex(index)},
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 4),
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Palette.colorGreen,
                width: (controller.getImageIndex() == index) ? 2 : 0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            imageList[index] + index.toString(),
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
        ),
      );

  Widget _productImageCard({BuildContext ctx, List<String> imageList}) => Card(
        margin: EdgeInsets.symmetric(horizontal: 16),
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.network(
          imageList[controller.getImageIndex()] +
              controller.getImageIndex().toString(),
          fit: BoxFit.cover,
          height: MediaQuery.of(ctx).size.height * 0.35,
          width: MediaQuery.of(ctx).size.width,
        ),
      );
}
