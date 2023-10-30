// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/app/data/database.dart';
import 'package:connect_app/app/integrations/firestore.dart';

class UserModel {
  String? id;
  String? nama;
  String? email;
  String? avatar;
  String? role;
  DateTime? tanggal;

  UserModel(
      {this.id, this.nama, this.email, this.avatar, this.role, this.tanggal});

  UserModel fromJson(DocumentSnapshot doc) {
    var json = doc.data() as Map<String, dynamic>?;
    return UserModel(
        id: doc.id,
        nama: json?['nama'],
        email: json?['email'],
        avatar: json?['avatar'],
        role: json?['role'],
        tanggal: (json?['tanggal'] as Timestamp?)?.toDate());
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'nama': nama,
        'email': email,
        'avatar': avatar,
        'role': role,
        'tanggal': tanggal
      };

  Database db = Database(
      collectionReference: firebaseFirestore.collection(
        usersCollection,
      ),
      storageReference: firebaseStorage.ref(usersCollection));

  Future<UserModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      avatar = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Stream<UserModel> streamList(String id) async* {
    yield* db.collectionReference.doc(id).snapshots().map((event) {
      print("event id = ${event.id}");
      return fromJson(event);
    });
  }

  Stream<List<UserModel>> allstreamList() async* {
    yield* db.collectionReference.snapshots().map((query) {
      List<UserModel> list = [];
      for (var doc in query.docs) {
        list.add(
          UserModel().fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
