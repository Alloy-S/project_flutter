import 'package:admins/const/const.dart';
import 'package:admins/controllers/order_controller.dart';
import 'package:admins/services/store_services.dart';
import 'package:admins/views/orders_screen/order_details.dart';
import 'package:admins/views/widgets/appbar_widget.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());

    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(
                                data: data[index],
                              ));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: boldText(
                            text: "${data[index]['order_code']}",
                            color: fontGrey),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                normalText(
                                    text: intl.DateFormat('EEE, dd MMM yyyy')
                                        .format(time),
                                    color: darkGrey),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payment_outlined,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(text: paid, color: red),
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "IDR ${data[index]['total_amount']}",
                            color: purpleColor,
                            size: 16.0),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                    }),
                  ),
                ),
              );
            }
          }),
    );
  }
}
