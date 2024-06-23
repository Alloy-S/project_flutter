import 'package:admins/const/const.dart';
import 'package:admins/controllers/profile_controller.dart';
import 'package:admins/views/widgets/custom_textfield.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:admins/services/raja_ongkir_service.dart';

class ShopSettings extends StatefulWidget {
  final dynamic data;
  const ShopSettings({super.key, this.data});

  @override
  State<ShopSettings> createState() => _ShopSettingsState();
}

class _ShopSettingsState extends State<ShopSettings> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.shopNameControler.text =
        widget.data['shop_name'] != '' ? widget.data['shop_name'] : '';
    controller.shopAddressControler.text =
        widget.data['shop_address'] != '' ? widget.data['shop_address'] : '';
    controller.shopMobileControler.text =
        widget.data['shop_mobile'] != '' ? widget.data['shop_mobile'] : '';
    controller.shopWebsiteControler.text =
        widget.data['shop_website'] != '' ? widget.data['shop_website'] : '';
    controller.shopDescControler.text =
        widget.data['shop_desc'] != '' ? widget.data['shop_desc'] : '';
    strProvince =
        widget.data['shop_province'] != '' ? widget.data['shop_province'] : '';
    strProvinceId = widget.data['shop_province_id'] != ''
        ? widget.data['shop_province_id']
        : '';
    strKota = widget.data['shop_kota'] != '' ? widget.data['shop_kota'] : '';
    strKotaId =
        widget.data['shop_kota_id'] != '' ? widget.data['shop_kota_id'] : '';
    //   controller.shopNameControler.text = widget.data['vendor_name'] != '' ? widget.data['vendor_name'] : '';
    //   controller.shopNameControler.text = widget.data['vendor_name'] != '' ? widget.data['vendor_name'] : '';
  }

  var strProvinceId = '';
  var strKotaId = '';
  var strProvince = '';
  var strKota = '';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0, color: white),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopAddress: controller.shopAddressControler.text,
                        shopName: controller.shopNameControler.text,
                        shopMobile: controller.shopMobileControler.text,
                        shopWebsite: controller.shopWebsiteControler.text,
                        shopDesc: controller.shopDescControler.text,
                        province: strProvince,
                        provinceId: strProvinceId,
                        kota: strKota,
                        kotaId: strKotaId,
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
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8),
                child: DropdownSearch<dynamic>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: const TextStyle(color: white),
                      dropdownSearchDecoration: InputDecoration(
                        labelText:
                            strProvince != '' ? strProvince : "Province Asal",
                        hintText: 'Pilih Province Asal',
                        labelStyle: const TextStyle(
                          color: white,
                        ),
                        hintStyle: const TextStyle(
                          color: white,
                        ),
                      )),
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                  ),
                  onChanged: (value) {
                    strProvinceId = value!.provinceId;
                    strProvince = value!.province;
                  },
                  itemAsString: (item) => item.province,
                  asyncItems: (text) {
                    return RajaOngkirService.fetchProvince();
                  },
                ),
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8),
                child: DropdownSearch<dynamic>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: const TextStyle(color: white),
                      dropdownSearchDecoration: InputDecoration(
                        labelText: strKota != '' ? strKota : "Kota Asal",
                        hintText: 'Pilih Kota Asal',
                        labelStyle: const TextStyle(
                          color: white,
                        ),
                        hintStyle: const TextStyle(
                          color: white,
                        ),
                      )),
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                  ),
                  onChanged: (value) {
                    strKotaId = value!.cityId;
                    strKota = "${value!.type} ${value!.cityName}";
                  },
                  itemAsString: (item) => "${item.type} ${item.cityName}",
                  asyncItems: (text) {
                    return RajaOngkirService.fetchKota(strProvinceId);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
