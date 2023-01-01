// ignore_for_file: file_names, must_be_immutable

import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ButtonForm extends StatelessWidget {
  ButtonForm({
    Key? key,
    required this.isSaving,
    required this.tapFunction,
    this.margin,
    this.messages,
    this.label,
  }) : super(key: key);
  RxBool isSaving;
  RxString? messages;
  String? label;
  void Function() tapFunction;
  EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppButton(
        child: isSaving.value
            ? Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    margin: EdgeInsets.only(bottom: 8),
                    child: CircularProgressIndicator(),
                  ),
                  if (messages is RxString) text(messages?.value),
                ],
              )
            : text(label ?? "Upload", textColor: colorWhite),
        onTap: isSaving.value ? null : tapFunction,
        margin: margin,
        color: colorPrimary,
        width: Get.width,
        padding: EdgeInsets.zero,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
    );
  }
}
