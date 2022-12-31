// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/app/data/database.dart';
import 'package:connect_app/app/integrations/firestore.dart';

const String uid = "id";
const String unama = "nama";
const String uemail = "email";
const String upassword = "password";
const String uavatar = "avatar";
const String urole = "role";

class UserModel {
  String? id;
  String? nama;
  String? email;
  String? password;
  String? avatar;
  String? role;

  UserModel(
      {this.id, this.nama, this.email, this.password, this.avatar, this.role});

  UserModel fromJson(DocumentSnapshot doc) {
    print("doc data = ${doc.data()}");
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserModel(
        id: doc.id,
        nama: json[unama],
        email: json[uemail],
        password: json[password],
        avatar: json[avatar],
        role: json[role]);
  }

  Map<String, dynamic> get toJson => {
        uid: id,
        unama: nama,
        uemail: email,
        upassword: password,
        uavatar: avatar,
        urole: role,
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
    print("getStream");
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
