// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/images.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:connect_app/app/widgets/imageSourceBottomSheet.dart';
import 'package:connect_app/app/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FormFoto extends StatelessWidget {
  String oldPath = '';
  String defaultPath;
  FormFoto({
    this.oldPath = '',
    this.defaultPath = no_image,
  });
  final ImagePicker _picker = ImagePicker();
  var xfoto = ''.obs;
  String get newPath => xfoto.value;

  getImage(bool isCam) async {
    var result = await _picker.pickImage(
      source: isCam ? ImageSource.camera : ImageSource.gallery,
    );
    // if (result is XFile) {
    //   xfoto.value = result.path;
    // }
    if (result is XFile) {
      xfoto.value = result.path;
    }
  }

  // void _setImageFileListFromFile(XFile? value) {
  //   imageFileList = value == null ? null : <XFile>[value];
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 16),
            width: Get.width,
            height: Get.width / 1.7,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: FotoWidget(
                  oldPath: oldPath,
                  newPath: newPath,
                  defaultPath: defaultPath,
                  margin: EdgeInsets.zero,
                )
                // newPath.isNotEmpty
                //     ? Image.file(File(newPath))
                //     : oldPath.isNotEmpty
                //         ? CachedNetworkImage(
                //             placeholder: placeholderWidgetFn() as Widget Function(
                //                 BuildContext, String)?,
                //             imageUrl: oldPath,
                //             fit: BoxFit.cover,
                //           )
                //         : SvgPicture.asset(
                //             defaultPath,
                //           ),
                ),
          ),
        ),
        ElevatedButton(
          child: text("Upload Foto",
              textColor: colorWhite, fontSize: textSizeSMedium),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: colorScaffold,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (builder) {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  return ImageSourceBottomSheet(fromCamera: () async {
                    await getImage(true);
                    Get.back();
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }, fromGaleri: () async {
                    await getImage(false);
                    Get.back();
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  });
                });
          },
        ),
      ],
    );
  }
}
