import 'package:admins/const/const.dart';
import 'package:admins/controllers/products_controller.dart';
import 'package:admins/views/products_screen/components/product_dropdown.dart';
import 'package:admins/views/products_screen/components/product_images.dart';
import 'package:admins/views/widgets/custom_textfield.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EditProduct extends StatefulWidget {
  final dynamic data;
  const EditProduct({super.key, this.data});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  var controller = Get.find<ProductsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.pnameController.text = widget.data['p_name'];
    controller.pdescController.text = widget.data['p_desc'];
    controller.ppriceController.text = widget.data['p_price'];
    controller.pquantityController.text = widget.data['p_quantity'];
    controller.categoryValue.value = widget.data['p_category'];
    controller.populateSubCategory(controller.categoryValue.value);
    controller.subcategoryValue.value = widget.data['p_subcategory'];
    controller.pImagesLink = widget.data['p_imgs'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Edit Product", color: white, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      if (controller.pImagesLink.isNotEmpty) {
                        await controller.uploadImage();
                      }

                      await controller.updateProduct(
                        docId: widget.data.id,
                          name: controller.pnameController.text,
                          desc: controller.pdescController.text,
                          price: controller.ppriceController.text,
                          quantity: controller.pquantityController.text,
                          category: controller.categoryValue.value,
                          subcategory: controller.subcategoryValue.value,
                          context: context);
                      Get.back();
                    },
                    child: boldText(text: save, color: white),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                  hint: "eg. BMW",
                  label: "Product Name",
                  controller: controller.pnameController,
                ),
                10.heightBox,
                customTextField(
                  hint: "Nice product",
                  label: "Description",
                  isDesc: true,
                  controller: controller.pdescController,
                ),
                10.heightBox,
                customTextField(
                  hint: "\$100",
                  label: "Price",
                  controller: controller.ppriceController,
                ),
                10.heightBox,
                customTextField(
                  hint: "eg. 20",
                  label: "Quantity",
                  controller: controller.pquantityController,
                ),
                10.heightBox,
                productDropdown('Category', controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropdown('Subcategory', controller.subcategoryList,
                    controller.subcategoryValue, controller),
                10.heightBox,
                const Divider(color: white),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) {
                        if (controller.pImagesList[index] != null) {
                          return Image.file(
                            controller.pImagesList[index],
                            width: 100,
                          ).onTap(() {
                            controller.pickImage(index, context);
                          });
                        } else if (controller.pImagesLink.length > index) {
                          if (controller.pImagesLink[index] != null) {
                            return Image.network(
                              controller.pImagesLink[index]!,
                              width: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            });
                          } else {
                            return productImages(label: "${index + 1}")
                                .onTap(() {
                              controller.pickImage(index, context);
                            });
                          }
                        } else {
                          return productImages(label: "${index + 1}").onTap(() {
                            controller.pickImage(index, context);
                          });
                        }
                      },
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
                const Divider(color: white),
                10.heightBox,
                boldText(text: "Choose product colors"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      9,
                      (index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          VxBox()
                              .color(Vx.randomPrimaryColor)
                              .roundedFull
                              .size(65, 65)
                              .make()
                              .onTap(() {
                            controller.selectedColorIndex.value = index;
                          }),
                          controller.selectedColorIndex.value == index
                              ? const Icon(
                                  Icons.done,
                                  color: white,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
