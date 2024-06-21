import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/category_screen/category_details.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget feautureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(imgS1, width: 40, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
        Get.to(()=> CategoryDetails(title: title));
      });
}
