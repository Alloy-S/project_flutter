import 'package:admins/const/const.dart';
import 'package:admins/services/raja_ongkir_service.dart';
import 'package:admins/views/profile_screen/shipping_detail.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:admins/views/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({super.key});

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  var strProvinceId = '';
  var strKotaId = '';
  var weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // List<Result> dataProvince = RajaOngkirService.fetchProvince();
    return Scaffold(
      backgroundColor: purpleColor,
      body: Column(
        children: [
          20.heightBox,
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
                strProvinceId = value!.provinceId;
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
                strProvinceId = value!.cityId;
              },
              itemAsString: (item) => "${item.type} ${item.cityName}",
              asyncItems: (text) {
                return RajaOngkirService.fetchKota(strProvinceId);
              },
            ),
          ),
          10.heightBox,
          customTextField(
              label: 'weight',
              hint: 'eg. 1000gr',
              controller: weightController),
          10.heightBox,
          TextButton(
              onPressed: ()  {
                // var data = await RajaOngkirService.checkAllCost(
                //   origin: "23",
                //   destination: "24",
                //   weight: "1000",
                // );


                Get.to(() => ShippingDetail());
              },
              child: 'Calculate'.text.color(white).make()),
        ],
      ),
    );
  }
}
