// ignore_for_file: must_be_immutable, use_key_in_widget_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  BottomNav({this.initialindex});
  int? initialindex;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: colorLight,
      style: TabStyle.reactCircle,
      color: colorPrimary,
      activeColor: colorPrimary,
      items: [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.search, title: 'Cari'),
        TabItem(icon: Icons.account_circle, title: 'Akun'),
      ],
      onTap: (index) {
        if (index == 0) {
          Get.toNamed(Routes.HOME);
        } else if (index == 1) {
          Get.toNamed(Routes.SEARCH);
        } else if (index == 2) {
          Get.toNamed(Routes.PROFIL);
        }
      },
      initialActiveIndex: initialindex,
    );
  }
}
