import 'package:admins/const/const.dart';
import 'package:admins/views/orders_screen/components/order_place.dart';
import 'package:admins/views/widgets/our_button.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth,
        child: ourButton(color: green, onPress: () {}, title: "Confirm Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //order delivery status section
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(
                        text: "Order Status:", color: fontGrey, size: 16.0),
                    SwitchListTile(
                      activeColor: green,
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: "Placed", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: "Confirmed", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: false,
                      onChanged: (value) {},
                      title: boldText(text: "on Delivery", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: false,
                      onChanged: (value) {},
                      title: boldText(text: "Delivered", color: fontGrey),
                    ),
                  ],
                )
                    .box
                    .padding(EdgeInsets.all(8))
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
              ),
              //order details section
              Column(
                children: [
                  orderPlaceDetails(
                    d1: "data['order_code']",
                    d2: "data['shipping_method']",
                    title1: "Order Code",
                    title2: "Shipping Method",
                  ),
                  orderPlaceDetails(
                    d1: DateTime.now(),
                    d2: "data['payment_method']",
                    title1: "Order Date",
                    title2: "Payment Method",
                  ),
                  orderPlaceDetails(
                    d1: "Unpaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            "{data['order_by_name']}".text.make(),
                            "{data['order_by_email']}".text.make(),
                            "{data['order_by_address']}".text.make(),
                            "{data['order_by_city']}".text.make(),
                            "{data['order_by_state']}".text.make(),
                            "{data['order_by_phone']}".text.make(),
                            "{data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Total Amount", color: purpleColor),
                              boldText(text: "\$300.0", color: red, size: 16.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  .box
                  .outerShadowMd
                  .white
                  .border(color: lightGrey)
                  .roundedSM
                  .make(),
              const Divider(),
              10.heightBox,
              boldText(text: "Ordered Products", color: fontGrey, size: 16.0),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(3, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          title1: "data['orders'][index]['title']",
                          title2: "data['orders'][index]['tprice']",
                          d1: "{data['orders'][index]['qty']}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: purpleColor,
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
