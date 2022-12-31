import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/app/integrations/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class Database {
  CollectionReference collectionReference;
  Reference storageReference;
  Database({required this.collectionReference, required this.storageReference});

  Future<String?> add(Map<String, dynamic> json) async {
    try {
      DocumentReference doc = await collectionReference.add(json);
      return doc.id;
    } on FirebaseException catch (e) {
      toast(e.toString());
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: "Gagal Menambahkan",
      //   onConfirm: () => Get.back(),
      //   textConfirm: "Oke",
      //   buttonColor: primary,
      //   cancelTextColor: primary,
      //   confirmTextColor: white,
      //   titleStyle: TextStyle(color: primary),
      //   middleTextStyle: TextStyle(color: primary)
      // );
    } catch (e) {
      toast(e.toString());
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: e.toString(),
      //   onConfirm: () => Get.back(),
      //   textConfirm: "Oke",
      //   buttonColor: primary,
      //   cancelTextColor: primary,
      //   confirmTextColor: white,
      //   titleStyle: TextStyle(color: primary),
      //   middleTextStyle: TextStyle(color: primary)
      // );
    }
  }

  Future edit(Map<String, dynamic> json) async {
    try {
      return await collectionReference.doc(json["id"]).update(json);
    } on FirebaseException catch (e) {
      toast(e.toString());
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: e.toString(),
      //   onConfirm: () => Get.back(),
      //   textConfirm: "Oke",
      //   buttonColor: primary,
      //   cancelTextColor: primary,
      //   confirmTextColor: white,
      //   titleStyle: TextStyle(color: primary),
      //   middleTextStyle: TextStyle(color: primary)
      // );
      rethrow;
    }
  }

  Future delete(String id, {String? url}) async {
    try {
      if (url is String) {
        await firebaseStorage.refFromURL(url).delete();
      }
      return await collectionReference.doc(id).delete();
    } on FirebaseException catch (e) {
      toast(e.toString());
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: e.toString(),
      //   onConfirm: () => Get.back(),
      //   textConfirm: "Oke",
      //   buttonColor: primary,
      //   cancelTextColor: primary,
      //   confirmTextColor: white,
      //   titleStyle: TextStyle(color: primary),
      //   middleTextStyle: TextStyle(color: primary)
      // );
      rethrow;
    }
  }

  Future<String?> upload({required String id, required File file}) async {
    try {
      String? url;
      var task = await storageReference.child(id).putFile(file);
      if (task.state == TaskState.success) {
        return await storageReference.child(id).getDownloadURL();
      }
      toast("Gagal Upload Gambar");
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: "Gagal Upload Gambar",
      //   onConfirm: () => Get.back(),
      //   textConfirm: "Oke",
      //   buttonColor: primary,
      //   cancelTextColor: primary,
      //   confirmTextColor: white,
      //   titleStyle: TextStyle(color: primary),
      //   middleTextStyle: TextStyle(color: primary)
      // );
    } on FirebaseException catch (e) {
      toast(e.toString());
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: e.toString(),
      //   onConfirm: () => Get.back(),
      //   textConfirm: "Oke",
      //   buttonColor: primary,
      //   cancelTextColor: primary,
      //   confirmTextColor: white,
      //   titleStyle: TextStyle(color: primary),
      //   middleTextStyle: TextStyle(color: primary)
      // );
      rethrow;
    } catch (e) {
      toast(e.toString());
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: e.toString(),
      //   onConfirm: () => Get.back(),
      //   textConfirm: "Oke",
      //   buttonColor: primary,
      //   cancelTextColor: primary,
      //   confirmTextColor: white,
      //   titleStyle: TextStyle(color: primary),
      //   middleTextStyle: TextStyle(color: primary)
      // );
      rethrow;
    }
  }
}
