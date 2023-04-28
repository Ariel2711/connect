// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace, unnecessary_null_in_if_null_operators, must_be_immutable, use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/formater.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:connect_app/app/widgets/appbar.dart';
import 'package:connect_app/app/widgets/beritaKategori.dart';
import 'package:connect_app/app/widgets/beritaList.dart';
import 'package:connect_app/app/widgets/beritaSlider.dart';
import 'package:connect_app/app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(controller.listberita.length);
    return Scaffold(
      backgroundColor: colorScaffold,
      appBar: appBarLocal(
          title: "CONNECT",
          isWithLogo: true,
          isConnectLogo: true,
          actions: [
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: text(dateFormatter(DateTime.now()),
                      fontSize: textSizeSMedium, textColor: colorWhite),
                ))
          ]),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TitleHome("Berita Terbaru", false)),
            ),
            10.height,
            BeritaSlider(listberita: controller.listberita),
            10.height,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TitleHome("Kategori Berita", true)),
            ),
            10.height,
            Container(
              height: 100,
              width: Get.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: menuList.length,
                  itemBuilder: (context, index) {
                    return KategoriBerita(
                      title: menuList[index][0]!,
                      asset: menuList[index][1]!,
                      onTap: menuList[index][2] ?? null,
                    );
                  }),
            ),
            10.height,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TitleHome("Berita Lainnya", true)),
            ),
            10.height,
            Container(
              width: Get.width,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: controller.listberita.length,
                  itemBuilder: (context, index) {
                    return BeritaList(
                      berita: controller.listberita[index],
                    );
                  }),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomNav(
        initialindex: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.INPUT);
        },
        backgroundColor: colorPrimary,
        child: Icon(
          Icons.add,
          color: colorWhite,
        ),
      ),
    );
  }
}

class TitleHome extends StatelessWidget {
  TitleHome(this.title, this.isSeach);
  String title;
  bool isSeach;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        8.width,
        Container(
          padding: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: colorPrimary, width: 2))),
          child: Row(
            children: [
              text(title,
                  fontWeight: FontWeight.bold, fontSize: textSizeMedium),
              SizedBox(width: 5),
              isSeach == true
                  ? Icon(
                      Icons.manage_search,
                      color: colorSecondary,
                    )
                  : 0.height,
            ],
          ),
        ),
      ],
    );
  }
}
