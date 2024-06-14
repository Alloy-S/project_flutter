import 'package:admins/const/const.dart';
import 'package:admins/controllers/profile_controller.dart';
import 'package:admins/views/widgets/custom_textfield.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0, color: white),
          actions: [
            controller.isloading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      // if image is not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }

                      // if old password matches data base
                      if (controller.snapshotData['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldpassController.text,
                            newPassword: controller.newPassController.text);

                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.newPassController.text);

                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpassController.text.isEmptyOrNull &&
                          controller.newPassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Some error occured");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save, color: white)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              controller.snapshotData['imageUrl'] == ''
                  ? Image.asset(imgProduct, width: 100, fit: BoxFit.cover,)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                  : Image.network(controller.snapshotData['imageUrl'], width: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                ),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(color: white),
              customTextField(
                  label: name,
                  hint: "eg. Alloysius Steven",
                  controller: controller.nameController),
              10.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change password")),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldpassController),
              10.heightBox,
              customTextField(
                  label: confirmPassword,
                  hint: passwordHint,
                  controller: controller.newPassController),
            ],
          ),
        ),
      ),
    );
  }
}
