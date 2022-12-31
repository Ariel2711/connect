// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/images.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  GlobalKey<FormState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffold,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            colorSecondary,
            colorPrimary,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Form(
                  key: form,
                  child: Column(children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        connectputih,
                      ),
                    ),
                    10.height,
                    text("CONNECT", textColor: colorWhite),
                    30.height,
                    boxContainer(padding: EdgeInsets.all(20), widgets: [
                      if (controller.isRegis)
                        AppTextField(
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                          textFieldType: TextFieldType.NAME,
                          showCursor: true,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: controller.nameC,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            fillColor: colorWhite,
                            filled: true,
                            label: Row(
                              children: [
                                Text(
                                  "Nama",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      if (controller.isRegis) 25.height,
                      AppTextField(
                        textStyle: TextStyle(
                          fontSize: 14,
                        ),
                        textFieldType: TextFieldType.EMAIL,
                        isValidationRequired: true,
                        showCursor: true,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: controller.emailC,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          fillColor: colorWhite,
                          filled: true,
                          label: Row(
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                      25.height,
                      AppTextField(
                        textStyle: TextStyle(
                          fontSize: 14,
                        ),
                        textFieldType: TextFieldType.PASSWORD,
                        showCursor: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: controller.passwordC,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          fillColor: colorWhite,
                          filled: true,
                          label: Row(
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      if (controller.isRegis) 25.height,
                      if (controller.isRegis)
                        AppTextField(
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                          textFieldType: TextFieldType.PASSWORD,
                          showCursor: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: controller.passwordC2,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            fillColor: colorWhite,
                            filled: true,
                            label: Row(
                              children: [
                                Text(
                                  "Konfirmasi Password",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      10.height,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            child: Text("Lupa Password?",
                                style: TextStyle(color: colorPrimary)),
                            onPressed: () {
                              // Get.toNamed(Routes.RESET);
                            }),
                      ),
                      10.height,
                      Obx(
                        () => InkWell(
                          onTap: controller.isSaving
                              ? null
                              : () async {
                                  if (form.currentState!.validate()) {
                                    controller.isSaving = true;
                                    controller.isRegis
                                        ? await controller.register()
                                        : await controller.login();
                                    controller.isSaving = false;
                                  }
                                },
                          child: Container(
                            height: 45,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    colorSecondary,
                                    colorPrimary,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                            ),
                            child: controller.isRegis
                                ? controller.isSaving
                                    ? Center(
                                        child: Text(
                                          "Loading...",
                                          style: TextStyle(color: colorWhite),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          "DAFTAR",
                                          style: TextStyle(
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                : controller.isSaving
                                    ? Center(
                                        child: Text(
                                        "Loading...",
                                        style: TextStyle(color: colorWhite),
                                      ))
                                    : Center(
                                        child: Text(
                                          "MASUK",
                                          style: TextStyle(
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      10.height,
                      TextButton(
                        onPressed: () {
                          controller.isRegis = !controller.isRegis;
                          controller.nameC.clear();
                          controller.passwordC.clear();
                          controller.passwordC2.clear();
                          controller.emailC.clear();
                        },
                        style:
                            ButtonStyle(visualDensity: VisualDensity.compact),
                        child: Text(
                            controller.isRegis
                                ? "Sudah Punya Akun? Login Disini!"
                                : "Belum Punya Akun? Daftar Disini!",
                            style: TextStyle(color: colorPrimary)),
                      ),
                      TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: colorPrimary,
                            ),
                            10.width,
                            Text("Masuk sebagai guest",
                                style: TextStyle(color: colorPrimary)),
                          ],
                        ),
                        onPressed: () => Get.offAndToNamed(Routes.HOME),
                      ),
                    ]),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
