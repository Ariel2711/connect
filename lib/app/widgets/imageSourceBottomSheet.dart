// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  ImageSourceBottomSheet({
    // required this.isSaving,
    required this.fromGaleri,
    required this.fromCamera,
  });

  // final RxBool isSaving;
  final void Function() fromGaleri;
  final void Function() fromCamera;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload Foto Berita dari",
            style: boldTextStyle(color: textPrimaryColor),
          ),
          16.height,
          Divider(height: 5),
          GestureDetector(
            onTap: fromGaleri,
            child: Container(
              color: colorScaffold,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.image_sharp,
                    color: colorPrimary,
                  ),
                  text(
                    "Galeri",
                    textColor: colorPrimary,
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 5),
          GestureDetector(
            onTap: fromCamera
            // masjidC.uploadImage(true);

            ,
            child: Container(
              color: colorScaffold,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.camera,
                    color: colorPrimary,
                  ),
                  text(
                    "Kamera",
                    textColor: colorPrimary,
                  ),
                ],
              ),
            ),
          ),
          8.height,
        ],
      ),
    );
  }
}
