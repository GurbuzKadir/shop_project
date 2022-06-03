import 'package:eshop/common/common.dart';
import 'package:eshop/ui/orderReturn/controller/order_return_controller.dart';
import 'package:get/get.dart';

class OrderReturnScreen extends GetView<OrderReturnController> {
  const OrderReturnScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "İadeler",
          style: context.toPopBoldFont(Palette.colorBlack),
        ),
        centerTitle: true,
      ),
      body: controller.obx((state) => Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/images/cartempty.png')),
                    Text(
                      "Henüz iade ürününüz bulunmamaktadır.",
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
                      style: context.toPop14RegularFont(Palette.colorGrey),
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
                        'Bize Ulaşın',
                        style: context.toPop18SemiBoldFont(Palette.colorWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
