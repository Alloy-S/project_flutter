import 'package:admins/const/const.dart';
import 'package:admins/services/store_services.dart';
import 'package:admins/views/products_screen/product_details.dart';
import 'package:admins/views/widgets/appbar_widget.dart';
import 'package:admins/views/widgets/dashboard_button.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> productSnapshot) {
          if (!productSnapshot.hasData) {
            return loadingIndicator();
          } else {
            var productData = productSnapshot.data!.docs;
            productData = productData.sortedBy((a, b) =>
              b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

            return StreamBuilder(
              stream: StoreServices.getOrders(currentUser!.uid),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> orderSnapshot) {
                if (!orderSnapshot.hasData) {
                  return loadingIndicator();
                } else {
                  var orderData = orderSnapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: products,
                                count: "${productData.length}",
                                icon: icProducts),
                            dashboardButton(context,
                                title: orders, count: "${orderData.length}", icon: icOrders),
                          ],
                        ),
                        10.heightBox,
                        const Divider(),
                        10.heightBox,
                        boldText(text: popular, color: fontGrey, size: 16.0),
                        20.heightBox,
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            productData.length,
                            (index) => productData[index]['p_wishlist'].length == 0
                                ? SizedBox()
                                : ListTile(
                                    onTap: () {
                                      Get.to(() => ProductDetails(
                                        data: productData[index],
                                      ));
                                    },
                                    leading: Image.network(
                                      productData[index]['p_imgs'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: boldText(
                                        text: "${productData[index]['p_name']}",
                                        color: fontGrey),
                                    subtitle: normalText(
                                        text: "\$${productData[index]['p_price']}",
                                        color: darkGrey),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            );
          }
        }
      ),
    );
  }
}
