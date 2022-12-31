import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

PreferredSizeWidget appbarWidget({
  required String title,
  required bool showDrawer,
  bool isWithLogo = false,
  bool isBordered = true,
  PreferredSizeWidget? bottom,
  List<Widget>? actions,
}) {
  return AppBar(
    iconTheme: IconThemeData(color: colorBlack),
    leading: BackButton(
      color: colorWhite,
    ),
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
        // gradient: LinearGradient(
        //   colors: [mkScaffoldColor, mkColorPrimary],
        //   begin: Alignment(0.5, 1),
        //   end: Alignment(0.6, -1),
        // ),
      ),
    ),
    centerTitle: true,
    bottom: bottom,
    title: text(title, fontSize: textSizeMedium, textColor: colorWhite),
  );
}
