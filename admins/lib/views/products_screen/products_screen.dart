import 'package:admins/const/const.dart';
import 'package:admins/controllers/products_controller.dart';
import 'package:admins/services/store_services.dart';
import 'package:admins/views/products_screen/add_product.dart';
import 'package:admins/views/products_screen/edit_product.dart';
import 'package:admins/views/products_screen/product_details.dart';
import 'package:admins/views/widgets/appbar_widget.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    var popupMenuController = VxPopupMenuController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          controller.resetController();
          await controller.getCategories();
          controller.populateCategoryList();

          Get.to(() => const AddProduct());
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
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(
                                data: data[index],
                              ));
                        },
                        leading: Image.network(
                          data[index]['p_imgs'][0],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(
                            text: "${data[index]['p_name']}", color: fontGrey),
                        subtitle: Row(
                          children: [
                            normalText(
                                text: "\$${data[index]['p_price']}",
                                color: darkGrey),
                            10.widthBox,
                            boldText(
                                text: data[index]['is_featured'] == true
                                    ? "Featured"
                                    : "",
                                color: green)
                          ],
                        ),
                        trailing: VxPopupMenu(
                            controller: popupMenuController,
                            arrowSize: 0.0,
                            child: Icon(Icons.more_vert_rounded),
                            menuBuilder: () => Column(
                                  children: List.generate(
                                    popupMenuTitles.length,
                                    (i) => Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            popupMenuIcons[i],
                                            color: data[index]['featured_id'] ==
                                                        currentUser!.uid &&
                                                    i == 0
                                                ? green
                                                : darkGrey,
                                          ),
                                          10.widthBox,
                                          normalText(
                                              text: data[index]
                                                              ['featured_id'] ==
                                                          currentUser!.uid &&
                                                      i == 0
                                                  ? "Remove featured"
                                                  : popupMenuTitles[i],
                                              color: darkGrey),
                                        ],
                                      ).onTap(() async {
                                        switch (i) {
                                          case 0:
                                            if (data[index]['is_featured']) {
                                              controller.removeFeatured(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg: "Removed");
                                            } else {
                                              controller
                                                  .addFeatured(data[index].id);
                                              VxToast.show(context,
                                                  msg: "Added");
                                            }
                                            break;
                                          case 1:
                                            await controller.getCategories();
                                            controller.populateCategoryList();
                                            Get.to(() => EditProduct(
                                                  data: data[index],
                                                ));
                                            break;
                                          case 2:
                                            controller
                                                .removeProduct(data[index].id);
                                            VxToast.show(context,
                                                msg: "Product removed");
                                            break;

                                          default:
                                        }
                                        popupMenuController.hideMenu();
                                      }),
                                    ),
                                  ),
                                ).box.white.rounded.width(200).make(),
                            clickType: VxClickType.singleClick),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
      // body
    );
  }
}
