import 'package:admins/const/const.dart';
import 'package:admins/models/rajaongkir_cost_model.dart';
import 'package:admins/services/raja_ongkir_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admins/views/widgets/loading_indicator.dart';

class ShippingDetail extends StatefulWidget {
  const ShippingDetail({super.key});

  @override
  State<ShippingDetail> createState() => _ShippingDetailState();
}

class _ShippingDetailState extends State<ShippingDetail> {
  // var controller = Get.find<Ra>()
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // data = RajaOngkirService.checkAllCost(
    //   origin: "23",
    //   destination: "24",
    //   weight: "1000",
    // );
  }

  @override
  Widget build(BuildContext context) {
    // for (Result2 item in data) {
    //   print(item.code);
    //   for (ResultCost item2 in item.costs) {
    //     print(item2.description);
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        title: "Select Courier".text.make(),
      ),
      
      body: FutureBuilder<dynamic>(
        future: RajaOngkirService.checkAllCost(
            origin: "23", destination: "24", weight: "1000"),
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
            return ListView.builder(
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
                      return Padding(
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
                                            ? "${item.description}".text.make()
                                            : "${item.service} ${item.description}"
                                                .text
                                                .make()
                                        // "${item.service}".text.make(),
                                      ],
                                    ),
                                    "IDR ${item.cost[0].value}".text.make(),
                                  ],
                                )),
                            Divider(),
                          ],
                        ),
                      );
                    }),
                  ),
                ).onTap(() {
                  print('hello');
                });
              },
            );
          }
        },
      ),
    );
  }
}
