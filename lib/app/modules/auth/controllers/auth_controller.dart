// ignore_for_file: prefer_final_fields, avoid_print

import 'package:connect_app/app/data/models/user_model.dart';
import 'package:connect_app/app/integrations/firestore.dart';
import 'package:connect_app/app/routes/app_pages.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> streamAuth() => _auth.authStateChanges();

  var role = "user";

  var currUser = UserModel().obs;
  UserModel get user => currUser.value;
  set user(UserModel value) => currUser.value = value;

  var _isRegis = false.obs;
  bool get isRegis => _isRegis.value;
  set isRegis(value) => _isRegis.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(value) => _isSaving.value = value;

  late Rx<User?> firebaseUser;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordC2 = TextEditingController();
  TextEditingController nameC = TextEditingController();

  login() async {
    try {
      final myuser = await _auth.signInWithEmailAndPassword(
          email: emailC.text, password: passwordC.text);
      if (myuser.user!.emailVerified) {
        Get.offAndToNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
            title: "Gagal Login",
            middleText:
                "Verifikasi email terlebih dahulu. Apakah verifikasi perlu dikirim ulang",
            onConfirm: () async {
              await myuser.user!.sendEmailVerification();
              Get.back();
            },
            textConfirm: "Iya",
            textCancel: "Tidak",
            buttonColor: colorPrimary,
            cancelTextColor: colorPrimary,
            confirmTextColor: colorWhite,
            titleStyle: TextStyle(color: colorPrimary),
            middleTextStyle: TextStyle(color: colorPrimary));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast('Tidak ada user untuk email ini');
      } else if (e.code == 'wrong-password') {
        toast('Password salah untuk email ini');
      } else {
        toast(e.toString());
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  register() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        nama: nameC.text,
        email: emailC.text,
        tanggal: DateTime.now(),
        avatar: "",
        role: role,
      );
      UserCredential myUser = await _auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );
      await myUser.user!.sendEmailVerification();
      user.id = myUser.user!.uid;
      if (user.id != null) {
        firebaseFirestore
            .collection(usersCollection)
            .doc(user.id)
            .set(user.toJson)
            .then((value) {
          Get.defaultDialog(
              title: "Verifikasi Email",
              middleText: "Kami telah mengirimkan verifikasi ke Email anda",
              textConfirm: "Oke",
              onConfirm: () {
                nameC.clear();
                passwordC.clear();
                emailC.clear();
                passwordC2.clear();
                Get.back();
                isRegis = false;
              },
              buttonColor: colorPrimary,
              cancelTextColor: colorPrimary,
              confirmTextColor: colorWhite,
              titleStyle: TextStyle(color: colorPrimary),
              middleTextStyle: TextStyle(color: colorPrimary));
        });
      }
      isSaving = false;
    } on FirebaseAuthException catch (e) {
      isSaving = false;
      if (e.code == 'weak-password') {
        toast('Password terlalu lemah');
      } else if (e.code == 'email-already-in-use') {
        toast('Akun sudah ada untuk email ini');
      } else {
        toast(e.toString());
      }
    }
  }

  void logout() async {
    Get.defaultDialog(
        title: "Logout",
        middleText: "Anda yakin ingin keluar?",
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          Get.back();
          isSaving = false;
          emailC.clear();
          passwordC.clear();
          Get.offAndToNamed(Routes.AUTH);
        },
        textConfirm: "Iya",
        textCancel: "Tidak",
        buttonColor: colorPrimary,
        cancelTextColor: colorPrimary,
        confirmTextColor: colorWhite,
        titleStyle: TextStyle(color: colorPrimary),
        middleTextStyle: TextStyle(color: colorPrimary));
  }

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      await _auth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil mengirim link reset password ke email anda",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "Oke",
          buttonColor: colorPrimary,
          cancelTextColor: colorPrimary,
          confirmTextColor: colorWhite,
          titleStyle: TextStyle(color: colorPrimary),
          middleTextStyle: TextStyle(color: colorPrimary));
    } else {
      Get.defaultDialog(
          title: "Error",
          middleText: "Email tidak valid",
          textConfirm: "Oke",
          onConfirm: () => Get.back(),
          buttonColor: colorPrimary,
          cancelTextColor: colorPrimary,
          confirmTextColor: colorWhite,
          titleStyle: TextStyle(color: colorPrimary),
          middleTextStyle: TextStyle(color: colorPrimary));
    }
  }

  streamUser(User? fuser) {
    if (fuser != null) {
      currUser.bindStream(UserModel().streamList(fuser.uid));
      print("auth id = " + fuser.uid);
    } else {
      print("null auth");
      user = UserModel();
    }
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, streamUser);
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.clear();
    passwordC.clear();
    passwordC2.clear();
    nameC.clear();
  }
}
