import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/view/cart_screen/shipping_screen.dart';
import 'package:emart_app/widgets_common/loadingIndicator.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            Get.to(() => const ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed to Shipping",
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart".text.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = data[index];
                        return ListTile(
                          leading: Image.network("${item['img']}"),
                          title: "${item['title']} (x${item['qty']})"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: redColor),
                                onPressed: () {
                                  controller.decrementQuantity(
                                      item.id, item['qty']);
                                },
                              ),
                              Text("${item['qty']}")
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                              IconButton(
                                icon: Icon(Icons.add, color: redColor),
                                onPressed: () {
                                  controller.incrementQuantity(
                                      item.id, item['qty']);
                                },
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              "${item['tprice']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make(),
                              Icon(Icons.delete, color: redColor).onTap(() {
                                FirestoreServices.deleteDocument(item.id);
                              }),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(lightGrey)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
