// import 'package:carousel_slider/carousel_slider.dart';
// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, file_names, must_be_immutable

import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/images.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';

class KategoriBerita extends StatelessWidget {
  KategoriBerita({required this.asset, required this.title, this.onTap});
  String asset;
  String title;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Ink(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  image: AssetImage(asset),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    colorBlack.withOpacity(0.5),
                    BlendMode.luminosity,
                  )),
            ),
            child: Center(
              child:
                  text(title, fontSize: textSizeMedium, textColor: colorWhite),
            )),
      ),
    );
  }
}

List<List> menuList = [
  ["Olahraga", ic_olahraga, () {}],
  [
    "Politik",
    ic_politik,
    () {},
  ],
  ["Hiburan", ic_hiburan, () {}],
  [
    "Sosial",
    ic_sosial,
    () {},
  ],
  [
    "Ekonomi",
    ic_ekonomi,
    () {},
  ],
];
