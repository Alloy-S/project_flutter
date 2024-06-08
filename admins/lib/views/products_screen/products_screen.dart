import 'package:admins/const/const.dart';
import 'package:admins/views/products_screen/add_product.dart';
import 'package:admins/views/products_screen/product_details.dart';
import 'package:admins/views/widgets/appbar_widget.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () {
          Get.to(() => AddProduct());
        },
        child: Icon(
          Icons.add,
          color: white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(50.0), // Ensuring the button is round
        ),
      ),
      appBar: appbarWidget(products),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              20,
              (index) => Card(
                child: ListTile(
                  onTap: () {
                    Get.to(() => ProductDetails());
                  },
                  leading: Image.asset(
                    imgProduct,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  title: boldText(text: "Product Title", color: fontGrey),
                  subtitle: normalText(text: "\$40.0", color: darkGrey),
                  trailing: VxPopupMenu(
                      arrowSize: 0.0,
                      child: Icon(Icons.more_vert_rounded),
                      menuBuilder: () => Column(
                            children: List.generate(
                              popupMenuTitles.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(popupMenuIcons[index]),
                                    10.widthBox,
                                    normalText(
                                        text: popupMenuTitles[index],
                                        color: darkGrey),
                                  ],
                                ).onTap(() {}),
                              ),
                            ),
                          ).box.white.rounded.width(200).make(),
                      clickType: VxClickType.singleClick),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
