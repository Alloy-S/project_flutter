import 'package:emart_app/consts/consts.dart';
import 'package:flutter/widgets.dart';

Widget feautureButton({String? title, icon}){
  return Row(
    children: [
      Image.asset(imgS1, width: 40, fit: BoxFit.fill),
      10.widthBox, 
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),

    ],
  ).box.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
}