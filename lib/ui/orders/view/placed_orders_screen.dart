import 'package:eshop/common/common.dart';
import 'package:eshop/ui/orders/controller/placed_orders_controller.dart';
import 'package:get/get.dart';

class PlacedOrdersScreen extends GetView<PlacedOrdersController> {
  const PlacedOrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Verilen siparişler",
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
            child: state?.length == 0
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
                            "Henüz bir siparişiniz yok.",
                            style: context
                                .toPop28RegularFont(Palette.colorBlack)
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Lütfen ödeme yapın veya daha fazla ürünü keşfedin.",
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
                              'Keşfet',
                              style: context
                                  .toPop18SemiBoldFont(Palette.colorWhite),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        padding: EdgeInsets.only(
                            bottom: 32, top: 16, left: 16, right: 16),
                        itemCount: state?.length ?? 0,
                        itemBuilder: _placedOrderView),
                  ),
          )),
    );
  }

  Widget _placedOrderView(BuildContext context, int index) => Container(
        child: Card(
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              controller.goToPlacedOrdersDetail(controller.state[index]?.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sipariş #" + controller.state[index].id ?? "#",
                      style: context.toPop10RegularFont(Palette.colorGrey)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "Üzerine çalışılıyor " +
                              controller.state[index].placedTime ??
                          "",
                      style: context.toPop12RegularFont(Palette.colorBlack)),
                  Divider(),
                  Wrap(children: [
                    Text("Sipariş durumu : ",
                        style: context.toPop12RegularFont(Palette.colorBlack)),
                    SizedBox(
                      width: 16,
                    ),
                    Text("İşlemde",
                        style: context
                            .toPop12RegularFont(Palette.colorGreen)
                            .copyWith(fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Wrap(children: [
                    Text("Tahmini Teslim Tarihi: ",
                        style: context.toPop12RegularFont(Palette.colorBlack)),
                    SizedBox(
                      width: 16,
                    ),
                    Text(controller.state[index].estimateDeliveryDate ?? "",
                        style: context
                            .toPop12RegularFont(Palette.colorBlack)
                            .copyWith(fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Wrap(children: [
                    Text("Toplam ürün : ",
                        style: context.toPop12RegularFont(Palette.colorBlack)),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                        controller.state[index].cartModel.length.toString() +
                                " ürünler" ??
                            "0 ürünler",
                        style: context
                            .toPop12RegularFont(Palette.colorBlack)
                            .copyWith(fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Wrap(children: [
                    Text("Nakliye ücreti : ",
                        style: context.toPop12RegularFont(Palette.colorBlack)),
                    SizedBox(
                      width: 16,
                    ),
                    Text("Ücretsiz",
                        style: context
                            .toPop12RegularFont(Palette.colorBlack)
                            .copyWith(fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Wrap(children: [
                    Text("Toplam tutar (KDV dahil) : ",
                        style: context.toPop12RegularFont(Palette.colorBlack)),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                        getBaht() + controller.state[index].totalPrice ??
                            "${getBaht()}0",
                        style: context
                            .toPop12RegularFont(Palette.colorBlack)
                            .copyWith(fontWeight: FontWeight.bold)),
                  ]),
                ],
              ),
            ),
          ),
        ),
      );

  void _deleteConfirmDialog(BuildContext ctx) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Sil',
          style: ctx.toPop18SemiBoldFont(Palette.colorBlack),
        ),
        content: Wrap(
          children: [
            Text(
              'Tüm siparişleri silmek istediğinizden emin misiniz?',
              style: ctx.toPop18RegularFont(Palette.colorBlack),
            ),
            Text(
              '(*aslında bu geliştirici modudur, Gerçek dünya hesabınızdan herhangi bir işlem siparişi listesini silemezsiniz, ancak siparişinizi şirket kurallarına uyarak iptal edebilirsiniz)',
              style: ctx.toPop10RegularFont(Palette.colorRed),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("İptal"),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text("Tamam"),
            onPressed: () {
              controller.clearAllOrders();
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
