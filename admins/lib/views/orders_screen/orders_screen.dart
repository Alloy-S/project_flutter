import 'package:admins/const/const.dart';
import 'package:admins/views/widgets/appbar_widget.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(orders),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              20,
              (index) => ListTile(
                onTap: () {},
                tileColor: textfieldGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: boldText(text: "Product Title", color: fontGrey),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: fontGrey,
                        ),
                        10.widthBox,
                        normalText(
                            text: intl.DateFormat('EEE, dd MMM yyyy')
                                .format(DateTime.now()),
                            color: darkGrey),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.payment_outlined,
                          color: fontGrey,
                        ),
                        10.widthBox,
                        boldText(text: unpaid, color: red),
                      ],
                    ),
                  ],
                ),
                trailing:
                    boldText(text: "\$40.0", color: purpleColor, size: 16.0),
              ).box.margin(const EdgeInsets.only(bottom: 4)).make(),
            ),
          ),
        ),
      ),
    );
  }
}
