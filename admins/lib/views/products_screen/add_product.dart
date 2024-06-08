import 'package:admins/const/colors.dart';
import 'package:admins/const/const.dart';
import 'package:admins/views/widgets/custom_textfield.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: "Add Product", color: white, size: 16.0),
        actions: [
          TextButton(
            onPressed: () {},
            child: boldText(text: save, color: purpleColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextField(
              hint: "eg. BMW",
              label: "Product Name",
            )
          ],
        ),
      ),
    );
  }
}
