// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/images.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

PreferredSizeWidget appBarWidget({
  required String title,
  bool showDrawer = false,
  bool isWithLogo = false,
  bool showBack = false,
  bool isConnectLogo = false,
  bool isCenter = false,
  bool isBordered = false,
  bool implyLeading = false,
  PreferredSizeWidget? bottom,
  List<Widget>? actions,
}) {
  return AppBar(
    automaticallyImplyLeading: implyLeading,
    iconTheme: IconThemeData(color: colorBlack),
    leadingWidth: Get.width / 2,
    leading: showBack
        ? BackButton(
            color: colorWhite,
          )
        : null,
    backgroundColor: colorPrimary,
    actions: showDrawer ? [] : actions ?? [56.width],
    elevation: 0,
    flexibleSpace: Container(
      width: Get.width,
      decoration: BoxDecoration(
        border: isBordered
            ? Border(
                bottom: BorderSide(color: textColorGrey),
              )
            : null,
        gradient: LinearGradient(
          colors: [colorSecondary, colorPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    centerTitle: isCenter,
    bottom: bottom,
    title: isWithLogo
        ? Row(
            children: [
              3.width,
              isConnectLogo
                  ? Image.asset(
                      connectputih,
                      height: 50,
                    )
                  : Icon(
                      Icons.account_circle,
                      color: colorWhite,
                      size: 40,
                    ),
              10.width,
              text(title, fontSize: textSizeMedium, textColor: colorWhite),
            ],
          )
        : text(title, fontSize: textSizeLargeMedium, textColor: colorWhite),
  );
}
