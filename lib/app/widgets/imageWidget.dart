// ignore_for_file: must_be_immutable, file_names, use_key_in_widget_constructors, body_might_complete_normally_nullable, sized_box_for_whitespace

import 'dart:io';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/images.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';

enum Ratio { empatpertiga, enamBelasPerSembilan, satuPerSatu, full }

enum Orientation { landscape, potrait }

class FotoWidget extends StatelessWidget {
  String oldPath = '';
  // List<String>? oldPaths = [];
  String newPath;
  String defaultPath;
  Ratio aspectRatio;
  Orientation orientation;
  double? width;
  EdgeInsets? margin;
  FotoWidget({
    this.aspectRatio = Ratio.enamBelasPerSembilan,
    this.orientation = Orientation.landscape,
    this.oldPath = '',
    // this.oldPaths,
    this.newPath = '',
    this.width,
    this.margin,
    this.defaultPath = no_image,
  });

  double? getHeight(Ratio ratio, Orientation orientation, double width) {
    if (orientation == Orientation.landscape) {
      switch (ratio) {
        case Ratio.empatpertiga:
          return Get.width / 4 * 3;
        case Ratio.enamBelasPerSembilan:
          return Get.width / 16 * 9;
        case Ratio.satuPerSatu:
          return Get.width;
        case Ratio.full:
          return null;
      }
    } else if (orientation == Orientation.potrait) {
      switch (ratio) {
        case Ratio.empatpertiga:
          return Get.width * 4 / 3;
        case Ratio.enamBelasPerSembilan:
          return Get.width * 16 / 9;
        case Ratio.satuPerSatu:
          return Get.width;
        case Ratio.full:
          return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: mkColorAccent,
      alignment: Alignment.center,
      margin: margin ?? EdgeInsets.only(bottom: 16),
      // decoration: boxDecoration(
      //     radius: 10.0, showShadow: true, color: mkColorPrimary),
      width: Get.width,
      height: getHeight(aspectRatio, orientation, Get.width),
      child: InkWell(
        onTap: () {
          !oldPath.isEmptyOrNull || !newPath.isEmptyOrNull
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: Get.height,
                      child: Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              // width: Get.width,
                              padding: EdgeInsets.only(top: 16, right: 16),
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () => Get.back(),
                                tooltip: "Close",
                                icon: Icon(
                                  Icons.clear,
                                  color: colorWhite,
                                ),
                              ),
                              color: colorBlack.withOpacity(0.7),
                            ),
                          ),
                          Expanded(
                            child: newPath.isEmptyOrNull
                                ? PhotoView(
                                    imageProvider: NetworkImage(oldPath),
                                    minScale: PhotoViewComputedScale.contained,
                                    backgroundDecoration: boxDecoration(
                                        radius: 0,
                                        bgColor: colorBlack.withOpacity(0.7)),
                                  )
                                : PhotoView(
                                    imageProvider: FileImage(File(newPath)),
                                    minScale: PhotoViewComputedScale.contained,
                                    backgroundDecoration: boxDecoration(
                                        radius: 0,
                                        bgColor: colorBlack.withOpacity(0.7)),
                                  ),
                          ),
                        ],
                      ),
                    );
                  })
              : null;
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: newPath.isNotEmpty
              ? Image.file(
                  File(newPath),
                  width: width,
                  fit: BoxFit.cover,
                )
              : oldPath.isNotEmpty
                  ? Image.network(
                      oldPath,
                      errorBuilder: (context, string, dynamic) =>
                          Image.asset(defaultPath),
                      width: width,
                      height: getHeight(
                          aspectRatio, orientation, width ?? Get.width),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      defaultPath,
                    ),
        ),
      ),
    );
  }
}
