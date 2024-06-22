import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/view/cart_screen/shipping_detail.dart';

import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:emart_app/services/rajaongkir_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatefulWidget {
  const ShippingDetails({super.key});

  @override
  State<ShippingDetails> createState() => _ShippingDetails();
}

class _ShippingDetails extends State<ShippingDetails> {
  // var strProvinceId = '';
  // var strKotaId = '';
  // var strProvince = '';
  // var strKota = '';

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () async {
            if (controller.addressController.text.length > 10) {
              print("shipping detail");
              await controller.getProductDetails();
              Get.to(() => ShippingDetail());
              // Get.to(() => const ShippingDetails());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                customTextfield(
                    hint: "Address",
                    isPass: false,
                    title: "Address",
                    controller: controller.addressController),
                customTextfield(
                    hint: "Phone",
                    isPass: false,
                    title: "Phone",
                    controller: controller.phoneController),
                customTextfield(
                    hint: "Postal Code",
                    isPass: false,
                    title: "Postal Code",
                    controller: controller.postalcodeController),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownSearch<dynamic>(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: 'Province Asal',
                      hintText: 'Pilih Province Asal',
                    )),
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    onChanged: (value) {
                      controller.strProvinceId.value = value!.provinceId;
                      controller.strProvince.value = value!.province;
                    },
                    itemAsString: (item) => item.province,
                    asyncItems: (text) {
                      return RajaOngkirService.fetchProvince();
                    },
                  ),
                ),
                20.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownSearch<dynamic>(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: 'Kota Asal',
                      hintText: 'Pilih Kota Asal',
                    )),
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    onChanged: (value) {
                      controller.strKotaId.value = value!.cityId;
                      controller.strKota.value = "${value!.type} ${value!.cityName}";
                    },
                    itemAsString: (item) => "${item.type} ${item.cityName}",
                    asyncItems: (text) {
                      return RajaOngkirService.fetchKota(controller.strProvinceId.value);
                    },
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
