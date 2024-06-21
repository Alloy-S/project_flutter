import 'package:admins/const/const.dart';
import 'package:admins/services/raja_ongkir_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({super.key});

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  var strProvinceId = '';
  var strKotaId = '';
  @override
  Widget build(BuildContext context) {
    // List<Result> dataProvince = RajaOngkirService.fetchProvince();
    return Scaffold(
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
        ],
      ),
    );
  }
}
