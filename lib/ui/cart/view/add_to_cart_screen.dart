import 'package:cart_stepper/cart_stepper.dart';
import 'package:eshop/common/common.dart';
import 'package:eshop/ui/cart/controller/add_to_cart_controller.dart';
import 'package:get/get.dart';

class AddToCartScreen extends GetView<AddToCartController> {
  const AddToCartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Sepet",
          style: context.toPopBoldFont(Palette.colorBlack),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _deleteConfirmDialog(context);
            },
            icon: Icon(
              Icons.delete_sweep_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: controller.obx((state) => Container(
            child: controller.getCartList().length == 0
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 200,
                              height: 200,
                              child:
                                  Image.asset('assets/images/cartempty.png')),
                          Text(
                            "Henüz sipariş vermediniz.",
                            style: context
                                .toPop28RegularFont(Palette.colorBlack)
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Bunu yaptığınızda, durum burada görünecektir.",
                            style:
                                context.toPop14RegularFont(Palette.colorGrey),
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
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Ürünlerimizi keşfedin',
                              style: context
                                  .toPop18SemiBoldFont(Palette.colorWhite),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  bottom: 32, top: 16, left: 16, right: 16),
                              shrinkWrap: true,
                              itemCount: controller.getCartList().length ?? 0,
                              itemBuilder: _cartProductView),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Text("Kupon Kodunuz",
                              style: context
                                  .toPop14RegularFont(Palette.colorBlack)
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 8),
                          child: TextField(
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: "kupon kodunu gir",
                                hintStyle: context
                                    .toPop12RegularFont(Palette.colorGrey),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.white10,
                                suffixIcon: TextButton.icon(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // <-- Radius
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.cyan.shade600),
                                  icon: Icon(
                                    Icons.qr_code_scanner_rounded,
                                    color: Palette.colorWhite,
                                  ),
                                  label: Text(
                                    "Uygulama",
                                    style: context
                                        .toPop12RegularFont(Palette.colorWhite),
                                  ),
                                )),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("sipariş özeti",
                              style: context
                                  .toPop14RegularFont(Palette.colorBlack)
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                dense: true,
                                visualDensity: VisualDensity(vertical: -3),
                                title: Text(
                                  "ara toplam",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: Text(
                                  "${getBaht()}${controller.getOrderSubTotal()}",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              ListTile(
                                dense: true,
                                visualDensity: VisualDensity(vertical: -3),
                                title: Text(
                                  "Nakliye ücreti",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: Text(
                                  "Ücretsiz",
                                  style: context.toPop14RegularFont(
                                      Colors.green.shade600),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              ListTile(
                                dense: true,
                                visualDensity: VisualDensity(vertical: -3),
                                title: Text(
                                  "İndirim",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: Text(
                                  "-${getBaht()}${controller.getOrderDiscount()}",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Divider(),
                              ListTile(
                                dense: true,
                                visualDensity: VisualDensity(vertical: -3),
                                title: Text(
                                  "Toplam(KDV Dahil)",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: Text(
                                  "${getBaht()}${controller.getTotalIncludeVAT()}",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              ListTile(
                                dense: true,
                                visualDensity: VisualDensity(vertical: -3),
                                title: Text(
                                  "Tahmini KDV",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: Text(
                                  "${getBaht()}${getVAT()}",
                                  style: context
                                      .toPop14RegularFont(Palette.colorBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Palette.colorDeepOrangeAccent,
                                onPrimary: Colors.white,
                              ),
                              onPressed: () {
                                controller.goToAddressesScreen();
                              },
                              child: Text(
                                'İleri',
                                style: context
                                    .toPop18SemiBoldFont(Palette.colorWhite),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
          )),
    );
  }

  void _deleteConfirmDialog(BuildContext ctx) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Sil',
          style: ctx.toPop18SemiBoldFont(Palette.colorBlack),
        ),
        content: Text(
          'Tüm listeyi silmek istediğinizden emin misiniz?',
          style: ctx.toPop18RegularFont(Palette.colorBlack),
        ),
        actions: [
          TextButton(
            child: const Text("İptal"),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text("Tamam"),
            onPressed: () {
              controller.clearAllCart();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget _cartProductView(BuildContext context, int index) => SizedBox(
        child: Card(
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                controller
                        .getProductDetail(controller
                            .getCartList()[index]
                            .productId
                            .toString())
                        .images[0] +
                    index.toString(),
                cacheHeight: 150,
                cacheWidth: 180,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(
                controller
                    .getProductDetail(
                        controller.getCartList()[index].productId.toString())
                    .title,
                style: context.toPop14RegularFont(Palette.colorBlack)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller
                      .getProductDetail(
                          controller.getCartList()[index].productId.toString())
                      .brand
                      .name,
                  style: context.toPop10RegularFont(Palette.colorGrey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(
                    getBaht() +
                        controller
                            .getProductDetail(controller
                                .getCartList()[index]
                                .productId
                                .toString())
                            .price,
                    style: context.toPop14RegularFont(Palette.colorBlack)),
                Divider(),
                Text(
                    "mevcut indirim: " +
                            controller
                                .getProductDetail(controller
                                    .getCartList()[index]
                                    .productId
                                    .toString())
                                .discountPercent
                                .toString() +
                            "%" ??
                        "",
                    style: context.toPop12RegularFont(Palette.colorBlue)),
                SizedBox(
                  height: 8,
                )
              ],
            ),
            trailing: Container(
              child: CartStepperInt(
                count: controller.getCartList()[index]?.count ?? 0,
                size: 26,
                elevation: 0,
                activeBackgroundColor: Colors.black87,
                activeForegroundColor: Palette.colorWhite,
                didChangeCount: (count) {
                  controller.changeCount(
                      controller.getCartList()[index].productId, count);
                },
              ),
            ),
          ),
        ),
      );
}
