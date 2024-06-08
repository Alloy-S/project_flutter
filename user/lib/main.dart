import 'package:emart_app/view/category_screen/category_screen.dart';
import 'package:emart_app/view/home_screen/home.dart';
import 'package:emart_app/view/home_screen/home_screen.dart';
import 'package:emart_app/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'consts/consts.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          //set app bar icons color
          iconTheme: IconThemeData(
            color: darkFontGrey
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}