import 'package:admins/const/const.dart';
import 'package:admins/controllers/auth_controller.dart';
import 'package:admins/controllers/profile_controller.dart';
import 'package:admins/services/store_services.dart';
import 'package:admins/views/auth_screen/login_screen.dart';
import 'package:admins/views/messages_screen/messages_screen.dart';
import 'package:admins/views/profile_screen/edit_profilescreen.dart';
import 'package:admins/views/shop_screen/shop_settings_screen.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EditProfileScreen(
                    username: controller.snapshotData['vendor_name'],
                  ));
            },
            icon: Icon(Icons.edit),
            color: white,
          ),
          TextButton(
              onPressed: () async {
                await Get.find<AuthController>().signoutMethod(context);
                Get.offAll(() => const LoginScreen());
              },
              child: normalText(text: logout, color: white)),
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circleColor: white);
          } else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ''
                        ? Image.asset(imgProduct, width: 100, fit: BoxFit.cover,)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.network(controller.snapshotData['imageUrl'], width: 100)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    title: boldText(
                        text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
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
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       ListTile(
      //         leading: Image.asset(imgProduct)
      //             .box
      //             .roundedFull
      //             .clip(Clip.antiAlias)
      //             .make(),
      //         title: boldText(text: "Vendor Name"),
      //         subtitle: normalText(text: "example@gmail.com"),
      //       ),
      //       const Divider(),
      //       10.heightBox,
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           children: List.generate(
      //             profileButtonsIcons.length,
      //             (index) => ListTile(
      //               onTap: () {
      //                 switch (index) {
      //                   case 0:
      //                     Get.to(() => ShopSettings());

      //                     break;
      //                   case 1:
      //                     Get.to(() => MessagesScreen());

      //                     break;
      //                   default:
      //                 }
      //               },
      //               leading: Icon(
      //                 profileButtonsIcons[index],
      //                 color: white,
      //               ),
      //               title: normalText(text: profileButtonsTitles[index]),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
