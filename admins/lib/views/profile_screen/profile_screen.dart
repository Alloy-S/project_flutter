import 'package:admins/const/const.dart';
import 'package:admins/views/messages_screen/messages_screen.dart';
import 'package:admins/views/profile_screen/edit_profilescreen.dart';
import 'package:admins/views/shop_screen/shop_settings_screen.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EditProfileScreen());
            },
            icon: Icon(Icons.edit),
            color: white,
          ),
          TextButton(
              onPressed: () {}, child: normalText(text: logout, color: white)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(imgProduct)
                  .box
                  .roundedFull
                  .clip(Clip.antiAlias)
                  .make(),
              title: boldText(text: "Vendor Name"),
              subtitle: normalText(text: "example@gmail.com"),
            ),
            const Divider(),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(
                  profileButtonsIcons.length,
                  (index) => ListTile(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(() => ShopSettings());

                          break;
                        case 1:
                          Get.to(() => MessagesScreen());

                          break;
                        default:
                      }
                    },
                    leading: Icon(
                      profileButtonsIcons[index],
                      color: white,
                    ),
                    title: normalText(text: profileButtonsTitles[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
