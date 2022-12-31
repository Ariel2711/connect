// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  bool isHome;
  BottomNav({this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // height: 65,
          // alignment: Alignment.center,
          width: Get.width,
          decoration: boxDecoration(
            showShadow: true,
            // radius: 100,
          ),
          // padding: EdgeInsets.all(4),
          // margin: EdgeInsets.all(16),
          child: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    //   (Get.currentRoute != RouteName.home &&
                    //           Get.previousRoute == RouteName.home)
                    //       ? Get.back()
                    //       : Get.offNamed(RouteName.home);
                    Get.toNamed(Routes.HOME);
                    // print(Get.previousRoute);
                  },
                  tooltip: 'Home',
                  icon: Icon(Icons.home),
                  iconSize: 30,
                  enableFeedback: true,
                  color: colorPrimary,
                ),
                IconButton(
                  onPressed: () {
                    // Get.toNamed(Routes.HOME);
                  },
                  tooltip: 'Cari Berita',
                  icon: Icon(Icons.search),
                  iconSize: 30,
                  enableFeedback: true,
                  color: colorPrimary,
                ),
                IconButton(
                  onPressed: () {
                    // authController.isLoggedIn.isTrue
                    //     ? Get.toNamed(Routes.HOME)
                    //     : Get.toNamed(Routes.HOME);
                  },
                  iconSize: 30,
                  tooltip: 'User Profile',
                  icon: Icon(Icons.person),
                  enableFeedback: true,
                  color: colorPrimary,
                )
              ],
            ),
          ),
        ));
  }
}
