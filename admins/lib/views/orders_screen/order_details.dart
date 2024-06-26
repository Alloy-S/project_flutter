import 'package:admins/const/const.dart';
import 'package:admins/controllers/order_controller.dart';
import 'package:admins/views/orders_screen/components/order_place.dart';
import 'package:admins/views/widgets/our_button.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:admins/views/orders_screen/components/order_courier_details.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var statusdeliver = 'Order Place';
        if (controller.onDelivery.value &&
            !controller.delivered.value &&
            !controller.confirmed.value) {
          statusdeliver = 'On Delivery';
        } else if (controller.onDelivery.value &&
            controller.delivered.value &&
            !controller.confirmed.value) {
          statusdeliver = 'Delivered';
        } else if (controller.onDelivery.value &&
            controller.delivered.value &&
            controller.confirmed.value) {
          statusdeliver = 'Order Finish';
        }
        return Scaffold(
          appBar: AppBar(
            title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
          ),
          bottomNavigationBar: Visibility(
            visible: controller.delivered.value && !controller.confirmed.value,
            child: SizedBox(
              height: 60,
              width: context.screenWidth,
              child: ourButton(
                  color: green,
                  onPress: () {
                    // print('confirm order press');
                    controller.confirmed(true);
                    controller.changeStatus(
                        title: 'order_confirmed',
                        status: true,
                        docID: widget.data.id);
                  },
                  title: "Confirm Order"),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //order delivery status section
                  Visibility(
                    visible: !controller.confirmed.value,
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
                        // SwitchListTile(
                        //   activeColor: green,
                        //   value: controller.confirmed.value,
                        //   onChanged: (value) {
                        //     controller.confirmed.value = value;
                        //   },
                        //   title: boldText(text: "Confirmed", color: fontGrey),
                        // ),
                        SwitchListTile(
                          activeColor: green,
                          value: controller.onDelivery.value,
                          onChanged: (value) {
                            controller.onDelivery.value = value;

                            controller.changeStatus(
                                title: 'order_on_delivery',
                                status: value,
                                docID: widget.data.id);
                          },
                          title: boldText(text: "on Delivery", color: fontGrey),
                        ),
                        SwitchListTile(
                          activeColor: green,
                          value: controller.delivered.value,
                          onChanged: (value) {
                            controller.delivered.value = value;
                            controller.changeStatus(
                                title: 'order_delivered',
                                status: value,
                                docID: widget.data.id);
                          },
                          title: boldText(text: "Delivered", color: fontGrey),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(8))
                        .outerShadowMd
                        .white
                        .border(color: lightGrey)
                        .roundedSM
                        .make(),
                  ),
                  //order details section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping Method",
                      ),
                      orderPlaceDetails(
                        // d1: DateTime.now(),
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format(widget.data['order_date'].toDate()),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order Date",
                        title2: "Payment Method",
                      ),
                      orderPlaceDetails(
                        d1: "Paid",
                        d2: statusdeliver,
                        title1: "Payment Status",
                        title2: "Delivery Status",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total Product"
                                      .text
                                      .fontWeight(FontWeight.w600)
                                      .make(),
                                  "${widget.data['total_product']}"
                                      .numCurrency
                                      .text
                                      .fontWeight(FontWeight.w600)
                                      .color(red)
                                      .make(),
                                  10.heightBox,
                                  "Total Amount"
                                      .text
                                      .fontWeight(FontWeight.w600)
                                      .make(),
                                  "${widget.data['total_amount']}"
                                      .numCurrency
                                      .text
                                      .fontWeight(FontWeight.w600)
                                      .color(red)
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            "${widget.data['order_by_name']}".text.make(),
                            "${widget.data['order_by_email']}".text.make(),
                            "${widget.data['order_by_address']}".text.make(),
                            "${widget.data['order_by_city']}".text.make(),
                            "${widget.data['order_by_state']}".text.make(),
                            "${widget.data['order_by_phone']}".text.make(),
                            "${widget.data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                      ),
                      orderCourierDetails(
                          title1: 'Courier Name',
                          title2: 'Harga',
                          d1: widget.data['courier'][0]['name'],
                          d2: widget.data['courier'][0]['value']),
                      orderCourierDetails(
                          title1: 'Service',
                          title2: 'Description',
                          d1: widget.data['courier'][0]['service'],
                          d2: widget.data['courier'][0]['description']),
                      orderCourierDetails(
                          title1: 'ETD',
                          title2: '',
                          d1: widget.data['courier'][0]['etd'],
                          d2: ''),
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
                  boldText(
                      text: "Ordered Products", color: fontGrey, size: 16.0),
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(controller.order.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetails(
                              title1: "${controller.order[index]['title']}",
                              title2: "${controller.order[index]['tprice']}",
                              d1: "${controller.order[index]['qty']}x",
                              d2: ""),
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
      },
    );
  }
}
