import 'package:admins/const/const.dart';
import 'package:admins/controllers/profile_controller.dart';
import 'package:admins/views/widgets/custom_textfield.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopSettings extends StatefulWidget {
  const ShopSettings({super.key});

  @override
  State<ShopSettings> createState() => _ShopSettingsState();
}

class _ShopSettingsState extends State<ShopSettings> {
  var controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0, color: white),
          actions: [
            controller.isloading.value ? loadingIndicator(circleColor: white) : TextButton(
                onPressed: () async {
                  controller.isloading(true);
                  await controller.updateShop(
                    shopAddress: controller.shopAddressControler.text,
                    shopName: controller.shopNameControler.text,
                    shopMobile: controller.shopMobileControler.text,
                    shopWebsite: controller.shopWebsiteControler.text,
                    shopDesc: controller.shopDescControler.text,
                  );

                  VxToast.show(context, msg: "Shop updated");
                },
                child: normalText(text: save, color: white)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                controller: controller.shopNameControler,
                label: shopName,
                hint: nameHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopAddressControler,
                label: address,
                hint: shopAddressHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopMobileControler,
                label: mobile,
                hint: shopMobileHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopWebsiteControler,
                label: website,
                hint: shopWebsiteHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopDescControler,
                isDesc: true,
                label: description,
                hint: shopDescHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
