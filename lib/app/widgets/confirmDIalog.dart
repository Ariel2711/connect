// ignore_for_file: file_names, use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: colorScaffold,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            24.height,
            Text("Perubahan belum tersimpan",
                style: boldTextStyle(color: textPrimaryColor, size: 18)),
            16.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: text(
                  "Perubahan anda belum tersimpan. Lanjut keluar halaman?",
                  textColor: textPrimaryColor,
                  fontSize: textSizeSMedium,
                  isLongText: true,
                  isCentered: true),
            ),
            16.height,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecoration(
                          color: colorPrimary,
                          radius: 8,
                          bgColor: colorScaffold),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.close,
                                          color: colorPrimary, size: 18))),
                              TextSpan(
                                  text: "Tidak",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: colorPrimary,
                                      fontFamily: "Regular")),
                            ],
                          ),
                        ),
                      ),
                    ).onTap(() {
                      Get.back(result: false);
                    }),
                  ),
                  16.width,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration:
                          boxDecoration(bgColor: colorPrimary, radius: 8),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.check,
                                          color: Colors.white, size: 18))),
                              TextSpan(
                                  text: "Ya",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontFamily: "Regular")),
                            ],
                          ),
                        ),
                      ),
                    ).onTap(() {
                      // FocusScope.of(context).unfocus();
                      // finish(context);
                      Get.back(result: true);
                      // return true;
                      // Navigator.of(context).pop();
                    }),
                  )
                ],
              ),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
