// import 'package:carousel_slider/carousel_slider.dart';
// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_app/app/data/models/berita_model.dart';
import 'package:connect_app/app/modules/home/controllers/home_controller.dart';
import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class BeritaList extends GetView<HomeController> {
  BeritaList({required this.berita});
  BeritaModel berita;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(berita);
    return Container(
        child: Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.DETAIL, arguments: berita);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: Get.width / 3,
                    height: Get.width / 3,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        placeholder: placeholderWidgetFn() as Widget Function(
                            BuildContext, String)?,
                        imageUrl: berita.image ?? '',
                        width: Get.width / 3,
                        height: Get.width / 3,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        text(
                          berita.judul,
                          textColor: textPrimaryColor,
                          fontSize: textSizeMedium,
                          maxLine: 2,
                        ),
                        6.height,
                        text(controller.getPlainQuill(berita.isi),
                            maxLine: 2, fontSize: textSizeSMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider()
      ],
    ));
  }
}
