// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:connect_app/app/data/models/berita_model.dart';
import 'package:connect_app/app/data/models/komentar_model.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/formater.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:connect_app/app/widgets/appbar.dart';
import 'package:connect_app/app/widgets/buttonForm.dart';
import 'package:connect_app/app/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  BeritaModel berita = Get.arguments ?? BeritaModel();
  Komentar komentar = Komentar();
  @override
  Widget build(BuildContext context) {
    controller.modelToController(berita);
    return Scaffold(
      backgroundColor: scaffoldLightColor,
      appBar: appBarLocal(title: "Baca Berita", showDrawer: false),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FotoWidget(
              oldPath: berita.image ?? '',
            ),
            Center(
              child: text(berita.judul,
                  textColor: textPrimaryColor,
                  fontSize: textSizeNormal,
                  fontWeight: FontWeight.w500,
                  isCentered: true,
                  isLongText: true),
            ),
            20.height,
            QuillEditor(
                scrollController: ScrollController(),
                scrollable: true,
                focusNode: FocusNode(canRequestFocus: false),
                autoFocus: false,
                expands: false,
                padding: EdgeInsets.zero,
                // keyboardAppearance: keyboardAppearance ?? Brightness.light,
                controller: controller.quillControllerisi,
                readOnly: true),
            // ),
            10.height,
            berita.tags == null || (berita.tags ?? []).isEmpty
                ? SizedBox()
                : Wrap(
                    children: List<Widget>.generate(
                      berita.tags?.length ?? 0,
                      (index) => TagCard(value: berita.tags![index]),
                    ),
                  ),
            8.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.public,
                  color: textPrimaryColor,
                ),
                4.width,
                Expanded(
                  child: text(dateFormatter(berita.tanggal),
                      fontSize: textSizeSMedium, textColor: textPrimaryColor),
                ),
              ],
            ),
            10.height,
            Obx(
              () => Container(
                width: Get.width,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: controller.listkomentar.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text(
                            controller.listkomentar[index].isi,
                          ),
                          Icon(Icons.delete)
                        ],
                      );
                    }),
              ),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) =>
              SimpleDialog(contentPadding: EdgeInsets.all(8), children: [
            inputText(
              controller: controller.komentarC,
              label: "Komentar Berita",
            ),
            15.height,
            ButtonForm(
              margin: EdgeInsets.all(16),
              tapFunction: () async {
                if (controller.isSaving.value == false) {
                  await controller.store(komentar, berita);
                }
              },
              isSaving: controller.isSaving,
            )
          ]),
        ),
      ),
    );
  }
}

class TagCard extends StatelessWidget {
  TagCard({
    Key? key,
    required this.value,
  }) : super(key: key);

  String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(4),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.local_offer_rounded,
              size: 18,
              color: colorPrimary,
            ),
            4.width,
            text(value, fontSize: textSizeSMedium),
          ],
        ),
      ),
    );
  }
}
