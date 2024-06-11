import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/view/auth_screen/signup_screen.dart';
import 'package:emart_app/view/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextfield(
                    title: email,
                    hint: emailHint,
                    isPass: false,
                    controller: controller.emailController),
                customTextfield(
                    title: password,
                    hint: passwordHint,
                    isPass: true,
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () async {
                          await controller
                              .loginMethod(context: context)
                              .then((onValue) {
                            if (onValue != null) {
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(() => const Home());
                            }
                          });
                        },
                        child: forgetPass.text.make())),
                5.heightBox,
                // outBottom().box.width(context.screenWidth - 50).make(),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        textColor: whiteColor,
                        title: login,
                        color: redColor,

                        onPress: () async {
                          controller.isLoading(true);

                          await controller.loginMethod(context: context).then((onValue){
                            if(onValue != null){
                              VxToast.show(context, msg: loggedin);
                              Get.off(() => const Home());
                            }else{
                              controller.isLoading(false);
                            }
                          });
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createnewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    textColor: whiteColor,
                    title: signup,
                    color: lightOrange,
                    onPress: () {
                      Get.to(() => const SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
        ],
      )),
    ));
  }
}
