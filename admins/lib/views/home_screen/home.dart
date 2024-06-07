import 'package:admins/const/const.dart';
import 'package:admins/controllers/home_controller.dart';
import 'package:admins/views/home_screen/home_screen.dart';
import 'package:admins/views/orders_screen/orders_screen.dart';
import 'package:admins/views/products_screen/products_screen.dart';
import 'package:admins/views/profile_screen/profile_screen.dart';
// import 'package:admins/views/widgets/text_style.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      HomeScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen(),
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: dashboard,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProducts, color: darkGrey, width: 24),
        label: products,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icOrders, color: darkGrey, width: 24),
        label: orders,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icGeneralSettings, color: darkGrey, width: 24),
        label: settings,
      ),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value)),
          ],
        ),
      ),
    );
  }
}
