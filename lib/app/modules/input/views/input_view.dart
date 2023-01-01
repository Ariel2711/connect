// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, unnecessary_this, unused_field

import 'package:connect_app/app/data/models/berita_model.dart';
import 'package:connect_app/app/modules/input/controllers/input_controller.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:connect_app/app/widgets/appbar.dart';
import 'package:connect_app/app/widgets/buttonForm.dart';
import 'package:connect_app/app/widgets/confirmDIalog.dart';
import 'package:connect_app/app/widgets/formFoto.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class InputBeritaView extends GetView<InputBeritaController> {
  BeritaModel berita = Get.arguments ?? BeritaModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBarWidget(
              title: berita.id.isEmptyOrNull ? "Tambah Berita" : "Edit Berita",
              showBack: true),
          body: StepperBody()),
    );
  }
}

// class StepperBody extends StatelessWidget {
class StepperBody extends StatefulWidget {
  const StepperBody({Key? key}) : super(key: key);
  @override
  _StepperBodyState createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  var currentStep = 0.obs;
  int get currStep => currentStep.value;
  set currStep(int value) => this.currentStep.value = value;

  GlobalKey<FormState> _form1 = GlobalKey();
  GlobalKey<FormState> _form2 = GlobalKey();
  GlobalKey<FormState> _form3 = GlobalKey();
  GlobalKey<FormState> _form4 = GlobalKey();
  bool validated1 = true;
  bool validated2 = true;
  bool validated3 = true;
  bool validated4 = true;

  BeritaModel berita = Get.arguments ?? BeritaModel();
  InputBeritaController controller = Get.find<InputBeritaController>();

  FormFoto formFoto = FormFoto();

  int? _groupValue;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = Iterable<int>.generate(3).map((e) => FocusNode()).toList();
    if (!berita.id.isEmptyOrNull) {
      controller.modelToController(berita);
      formFoto.oldPath = berita.image ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.judulberitaC.clear();
    controller.quillControllerisi.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: text("Judul Berita",
            textColor: textPrimaryColorGlobal, fontSize: textPrimarySizeGlobal),
        isActive: currStep == 0,
        state: validated1 ? StepState.indexed : StepState.error,
        content: Form(
          key: _form1,
          child: inputText(
            isEnabled: !controller.isSaving.value,
            controller: controller.judulberitaC,
            isValidationRequired: true,
            label: "Judul Berita",
            icon: Icon(Icons.volunteer_activism,
                color:
                    controller.isSaving.value ? colorSecondary : textColorGrey),
          ),
        ),
      ),
      Step(
        isActive: currStep == 1,
        state: validated2 ? StepState.indexed : StepState.error,
        title: text("Isi Berita",
            textColor: textPrimaryColorGlobal, fontSize: textPrimarySizeGlobal),
        content: Form(
          key: _form2,
          child: Column(children: [
            FormField(
                validator: (value) => controller.quillControllerisi.document
                            .toPlainText()
                            .length <
                        2
                    ? "Isi Berita can't be empty"
                    : null,
                builder: (field) => field.hasError
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: text(field.errorText,
                            fontSize: textSizeSMedium, textColor: Colors.red),
                      )
                    : SizedBox()),
            QuillToolbar.basic(
                multiRowsDisplay: true,
                controller: controller.quillControllerisi),
            10.height,
            Container(
              decoration: boxDecorationRoundedWithShadow(12,
                  shadowColor: Colors.grey.withOpacity(0.2)),
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: QuillEditor.basic(
                    controller: controller.quillControllerisi, readOnly: false),
              ),
            ),
          ]),
        ),
      ),
      Step(
        title: text("Kategori Berita",
            textColor: textPrimaryColorGlobal, fontSize: textPrimarySizeGlobal),
        isActive: currStep == 2,
        state: validated4 ? StepState.indexed : StepState.error,
        content: Form(
          key: _form4,
          child: DropdownSearch<String>(
            key: controller.tipeKategori,
            items: ["Olahraga", "Politik", "Sosial", "Ekonomi", "Hiburan"],
            itemAsString: (value) => value ?? '',
            mode: Mode.MENU,
            validator: (value) =>
                value == null ? "This field is required" : null,
            selectedItem: controller.selectedKategori,
            enabled: !controller.isSaving.value,
            onChanged: (value) => controller.selectedKategori = value,
            dropdownSearchDecoration: InputDecoration(
                labelText: "Kategori",
                icon: Icon(
                  Icons.category,
                  color: colorPrimary,
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ),
      Step(
        title: text("Media Berita",
            textColor: textPrimaryColorGlobal, fontSize: textPrimarySizeGlobal),
        isActive: currStep == 3,
        state: validated3 ? StepState.indexed : StepState.error,
        content: Form(
          key: _form3,
          child: Column(children: [
            FormField(
                validator: (value) {
                  return formFoto.newPath.isEmptyOrNull &&
                          formFoto.oldPath.isEmptyOrNull
                      ? "Media can't be empty"
                      : null;
                },
                builder: (field) => field.hasError
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(16),
                        child: text(field.errorText,
                            fontSize: textSizeSMedium, textColor: Colors.red),
                      )
                    : SizedBox()),
            formFoto,
          ]),
        ),
      ),
      Step(
        title: text("Tags Berita",
            textColor: textPrimaryColorGlobal, fontSize: textPrimarySizeGlobal),
        isActive: currStep == 4,
        state: StepState.indexed,
        content: Column(children: [
          inputText(
            icon: Icon(Icons.local_offer_rounded),
            label: "Tambah Tags",
            controller: controller.tagC,
            isValidationRequired: false,
            onFieldSubmitted: (value) {
              if (controller.tags.contains(controller.tagC.text)) {
                toast("Tags already exists");
                controller.tagC.clear();
              } else if (controller.tagC.text.removeAllWhitespace.isNotEmpty) {
                controller.tags.add(controller.tagC.text);
                controller.tagC.clear();
              } else {
                toast("Tag can't be empty");
              }
            },
            suffix: IconButton(
              onPressed: () {
                if (controller.tags.contains(controller.tagC.text)) {
                  toast("Tags already exists");
                  controller.tagC.clear();
                } else if (controller
                    .tagC.text.removeAllWhitespace.isNotEmpty) {
                  controller.tags.add(controller.tagC.text);
                  controller.tagC.clear();
                } else {
                  toast("Tag can't be empty");
                }
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: colorPrimary,
              ),
            ),
          ),
          12.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("Tags : ").marginOnly(top: 10),
              Expanded(
                child: Obx(
                  () => controller.tags.isEmpty
                      ? SizedBox()
                      : Wrap(
                          children: List<Widget>.generate(
                            controller.tags.length,
                            (index) => Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.all(4),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    text(controller.tags[index]),
                                    2.width,
                                    InkWell(
                                      onTap: () =>
                                          controller.tags.removeAt(index),
                                      child: Icon(
                                        Icons.highlight_off_rounded,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ]),
      ),
    ];
    return WillPopScope(
        onWillPop: () async {
          return controller.checkControllers(berita, formFoto.newPath)
              ? await showDialog(
                  context: context,
                  builder: (BuildContext context) => ConfirmDialog())
              : Future.value(true);
        },
        child: Container(
            child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => Stepper(
                    steps: steps,
                    type: StepperType.vertical,
                    currentStep: currStep,
                    physics: ScrollPhysics(),
                    controlsBuilder: (BuildContext context, control) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          currStep != 0
                              ? TextButton(
                                  onPressed: control.onStepCancel,
                                  child: text("Sebelum",
                                      textColor: textSecondaryColorGlobal,
                                      fontSize: textSecondarySizeGlobal),
                                )
                              : 10.width,
                          currStep < steps.length - 1
                              ? TextButton(
                                  onPressed: control.onStepContinue,
                                  child: text("Selanjutnya",
                                      textColor: textSecondaryColorGlobal,
                                      fontSize: textSecondarySizeGlobal),
                                )
                              : 10.width,
                        ],
                      );
                    },
                    onStepContinue: () {
                      setState(() {
                        if (currStep < steps.length - 1) {
                          currStep = currStep + 1;
                        } else {
                          finish(context);
                        }
                      });
                    },
                    onStepCancel: () {
                      // finish(context);
                      setState(() {
                        if (currStep > 0) {
                          currStep = currStep - 1;
                        } else {
                          currStep = 0;
                        }
                      });
                    },
                    onStepTapped: (step) {
                      setState(() {
                        currStep = step;
                      });
                    },
                  ),
                ),
              ),
              ButtonForm(
                margin: EdgeInsets.all(16),
                messages: controller.upMessage,
                tapFunction: () async {
                  if (controller.isSaving.value == false) {
                    if ((_form1.currentState?.validate() ?? true) &&
                        (_form2.currentState?.validate() ?? true) &&
                        (_form3.currentState?.validate() ?? true) &&
                        (_form4.currentState?.validate() ?? true)) {
                      // String? path = controller.tipeMedia == 10
                      //     ? formFoto.newPath
                      //     : formVideo.newPath;
                      String? path = formFoto.newPath;
                      if (path.isEmptyOrNull && berita.id.isEmptyOrNull) {
                        Get.snackbar("Error", "Media masih kosong");
                      } else if (!path.isEmptyOrNull) {
                        await controller.store(berita, path: path);
                      } else {
                        await controller.store(
                          berita,
                        );
                      }
                    }
                    validated1 = (_form1.currentState?.validate() ?? true);
                    validated2 = (_form2.currentState?.validate() ?? true);
                    validated3 = (_form3.currentState?.validate() ?? true);
                    validated4 = (_form3.currentState?.validate() ?? true);
                    setState(() {});
                  }
                },
                isSaving: controller.isSaving,
              )
            ],
          ),
        )));
  }
}
