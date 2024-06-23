import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/rajaongkir_service.dart';
import 'package:emart_app/view/cart_screen/payment_method.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emart_app/widgets_common/loadingindicator.dart';
// import 'package:emart_app/widgets_common/our_button.dart';
// import 'package:emart_app/view/cart_screen/payment_method.dart';

class ShippingDetail extends StatefulWidget {
  const ShippingDetail({super.key});

  @override
  State<ShippingDetail> createState() => _ShippingDetailState();
}

class _ShippingDetailState extends State<ShippingDetail> {
  var controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    print('shipping page');

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Select Courier".text.make(),
      ),
      // body: Container(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controller.strVendorKota.value.text.make(),
                const Icon(Icons.arrow_forward),
                controller.strKota.value.text.make(),
              ],
            ),
          ),
          FutureBuilder<dynamic>(
            future: RajaOngkirService.checkAllCost(
                origin: controller.strVendorKotaId.value,
                destination: controller.strKotaId.value,
                weight: controller.weight[0].toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: loadingIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                var allCost = snapshot.data!;
                print(allCost);
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allCost.length,
                    itemBuilder: (context, index) {
                      var result = allCost[index];
                      return Container(
                        child: Column(
                          children: List.generate(
                              // shrinkWrap: true,
                              result.costs.length, (index) {
                            var item = result.costs[index];
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8),
                                        // decoration: BoxDecoration(
                                        //   border: Border.all(color: Colors.black),
                                        // ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                "${result.name}".text.make(),
                                                // "${item.description}".text.make(),
                                                item.description == item.service
                                                    ? "${item.description}"
                                                        .text
                                                        .make()
                                                    : "${item.service} ${item.description}"
                                                        .text
                                                        .make()
                                                // "${item.service}".text.make(),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                "IDR ${item.cost[0].value}"
                                                    .text
                                                    .make(),
                                                item.cost[0].etd
                                                        .contains('HARI')
                                                    ? "${item.cost[0].etd}"
                                                        .text
                                                        .make()
                                                    : "${item.cost[0].etd} HARI"
                                                        .text
                                                        .make(),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Divider(),
                                  ],
                                ),
                              ),
                            ).onTap(() {
                              print('${item.service} ${item.description}');
                              controller.addCourier(
                                  name: result.name,
                                  service: item.service,
                                  description: item.description,
                                  value: item.cost[0].value,
                                  etd: item.cost[0].etd,
                                  cityId: controller.strVendorKotaId.value,
                                  cityName: controller.strKota.value,
                                  provinceId:
                                      controller.strVendorProvinceId.value,
                                  provinceName: controller.strVendorProvince.value);
                              Get.to(() => PaymentMethods());
                            });
                          }),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
