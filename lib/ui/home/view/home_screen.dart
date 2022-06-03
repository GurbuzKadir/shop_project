import 'package:badges/badges.dart';
import 'package:eshop/common/common.dart';
import 'package:eshop/ui/categories/view/categories_screen.dart';
import 'package:eshop/ui/home/controller/home_controller.dart';
import 'package:eshop/ui/profile/view/profile_screen.dart';
import 'package:eshop/ui/shop/view/shop_screen.dart';
import 'package:get/get.dart';
import 'package:eshop/ui/qr/qr_scan_screen.dart';

class HomeScreen extends GetView<HomeController> {
  final List _widgetOptions = [
    ShopScreen("Shop Page"),
    CategoriesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: controller.obx((state) {
          return Text(
            "Shop",
            style: context.toPopBoldFont(Palette.colorBlack),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaraApp()),
              );
              //controller.goToNotificationList();
            },
            icon: Icon(
              Icons.qr_code_2,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.goToNotificationList();
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
          ),
          Badge(
            badgeColor: Palette.colorDeepOrangeAccent,
            position: BadgePosition.topEnd(top: 0, end: 3),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            badgeContent: controller.obx(
              (state) => Text(
                state.length?.toString() ?? "0",
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  controller.goToCartList();
                }),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: Obx(
        () => Container(
          child: Center(
            child: _widgetOptions.elementAt(controller.getTabIndex()),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Anasayfa"),
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_view), label: "Kategoriler"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined), label: "Profil")
          ],
          currentIndex: controller.getTabIndex(),
          selectedItemColor: Palette.colorDeepOrangeAccent,
          onTap: controller.changeTabIndex,
        ),
      ),
    );
  }
}
