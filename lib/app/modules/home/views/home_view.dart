// ignore_for_file: unnecessary_string_interpolations
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/formater.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:connect_app/app/widgets/appbar.dart';
import 'package:connect_app/app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScaffold,
        appBar: widgetAppbar(
            title: "CONNECT",
            isWithLogo: true,
            isCenter: false,
            isBordered: false,
            showBack: false,
            showDrawer: false,
            actions: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: text(dateFormatter(DateTime.now()),
                        fontSize: textSizeSMedium, textColor: colorWhite),
                  ))
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(children: [
            Column(
              children: [
                text("Berita terbaru",
                    textColor: colorPrimary, fontWeight: FontWeight.bold),
              ],
            )
          ]),
        ),
        bottomNavigationBar: BottomNav(
          initialindex: 0,
        ));
  }
}
