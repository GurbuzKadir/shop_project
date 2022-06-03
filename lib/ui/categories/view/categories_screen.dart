import 'package:eshop/common/common.dart';
import 'package:eshop/ui/categories/controller/categories_controller.dart';
import 'package:get/get.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: controller.obx((state) => Column(children: [
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: Icon(Icons.search_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      hintText: 'Enter a search term',
                      labelStyle: context.toPop12RegularFont(Palette.colorGrey),
                      hintStyle: context.toPop12RegularFont(Palette.colorGrey)),
                ),
              ),*/
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 32, top: 16),
                  shrinkWrap: true,
                  itemCount: state?.categories?.length ?? 0,
                  itemBuilder: _categoryView,
                ),
              ),
            ])),
      ),
    );
  }

  Widget _categoryView(BuildContext ctx, int index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () => {
/*
            Navigator.push(ctx,
                MaterialPageRoute(builder: (context) => ProductListScreen()))
*/

            // Get.to(ProductListScreen())
            controller.goToProductList(
                index: controller.state.categories[index].id,
                type: 0,
                title: controller.state.categories[index].name)
          },
          child: Card(
            color: Palette.colorPurple,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  controller.state.categories[index].icon +
                      controller.state.categories[index].id.toString(),
                  fit: BoxFit.cover,
                  height: 150,
                  width: MediaQuery.of(ctx).size.width,
                  color: Colors.black.withOpacity(0.5),
                  colorBlendMode: BlendMode.darken,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 50),
                    child: Column(
                      children: [
                        Text(
                          controller.state.categories[index].name ?? "",
                          style: ctx.toBeba64RegularFont(Palette.colorWhite),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.goToProductList(
                          index: index,
                          type: 0,
                          title: controller.state.categories[index].name);
                    },
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
        ),
      );
}
