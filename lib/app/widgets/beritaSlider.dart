// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connect_app/app/data/models/berita_model.dart';
import 'package:connect_app/app/modules/home/controllers/home_controller.dart';
import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeritaSlider extends GetView<HomeController> {
  BeritaSlider({required this.listberita});
  List<BeritaModel> listberita;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
            listberita.length > 5 ? 5 : listberita.length,
            (index) => Builder(
              builder: (BuildContext context) {
                BeritaModel berita = controller.listberita[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL, arguments: berita);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              width: Get.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                  ),
                                  child: CachedNetworkImage(
                                    placeholder: placeholderWidgetFn() as Widget
                                        Function(BuildContext, String)?,
                                    imageUrl: berita.image ?? '',
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              text(
                                berita.judul,
                                maxLine: 2,
                                fontSize: textSizeMedium,
                                textColor: textColorPrimary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              controller.currentPos = index;
            },
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            enableInfiniteScroll: true,
          ),
        ),
        listberita.length < 2
            ? SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listberita.map((url) {
                  int index = listberita.indexOf(url);
                  return Center(
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentPos == index
                            ? colorPrimary
                            : textColorGrey,
                      ),
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }
}
