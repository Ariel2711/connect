// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unrelated_type_equality_checks, avoid_print
import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/images.dart';
import 'package:connect_app/app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  GlobalKey<FormState> form = GlobalKey();
  AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Harap isi nama Anda';
                            }
                            return null;
                          },
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
                              15,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Harap isi email Anda';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Harap isi password Anda';
                          }
                          return null;
                        },
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Harap konfirmasi password Anda';
                            }
                            return null;
                          },
                        ),
                      15.height,
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: text("Lupa Password?",
                                textColor: colorPrimary,
                                fontSize: textSizeMedium),
                          )),
                      15.height,
                      Obx(
                        () => InkWell(
                          onTap: controller.isSaving
                              ? null
                              : () async {
                                  if (form.currentState!.validate()) {
                                    print("submit");
                                    controller.isSaving = true;
                                    controller.isRegis
                                        ? controller.passwordC.text ==
                                                controller.passwordC2.text
                                            ? await controller.register()
                                            : toast("Password tidak cocok")
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
                      15.height,
                      GestureDetector(
                        child: text(
                            controller.isRegis
                                ? "Sudah Punya Akun? Login Disini!"
                                : "Belum Punya Akun? Daftar Disini!",
                            textColor: colorPrimary,
                            fontSize: textSizeMedium),
                        onTap: () {
                          controller.isRegis = !controller.isRegis;
                          controller.nameC.clear();
                          controller.passwordC.clear();
                          controller.passwordC2.clear();
                          controller.emailC.clear();
                        },
                      ),
                      15.height,
                      GestureDetector(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: colorPrimary,
                                ),
                                10.width,
                                text("Masuk sebagai guest",
                                    textColor: colorPrimary,
                                    fontSize: textSizeMedium)
                              ]),
                          onTap: () => Get.offAndToNamed(Routes.HOME)),
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
