// ignore_for_file: body_might_complete_normally_nullable

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
    } catch (e) {
      toast(e.toString());
    }
  }

  Future edit(Map<String, dynamic> json) async {
    try {
      return await collectionReference.doc(json["id"]).update(json);
    } on FirebaseException catch (e) {
      toast(e.toString());
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
      rethrow;
    }
  }

  Future<String?> upload({required String id, required File file}) async {
    try {
      var task = await storageReference.child(id).putFile(file);
      if (task.state == TaskState.success) {
        return await storageReference.child(id).getDownloadURL();
      }
      toast("Gagal Upload Gambar");
    } on FirebaseException catch (e) {
      toast(e.toString());
      rethrow;
    } catch (e) {
      toast(e.toString());
      rethrow;
    }
  }
}
