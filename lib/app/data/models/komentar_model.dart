// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/app/data/database.dart';
import 'package:connect_app/app/integrations/firestore.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class Komentar {
  String? id;
  String? beritaId;
  String? isi;
  DateTime? tanggal;

  Komentar({this.id, this.beritaId, this.isi});

  Komentar.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>?;
    id = doc.id;
    beritaId = json?['beritaId'];
    isi = json?['isi'];
    tanggal = (json?['tanggal'] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> get toJson =>
      {'id': id, 'beritaId': beritaId, 'isi': isi, 'tanggal': tanggal};

  Database get db => Database(
      collectionReference: firebaseFirestore
          .collection(beritaCollection)
          .doc(beritaId)
          .collection(komentarCollection),
      storageReference:
          firebaseStorage.ref(beritaCollection).child(komentarCollection));

  Future<Komentar> save() async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    return this;
  }

  Future delete() async {
    if (id.isEmptyOrNull) {
      Get.snackbar("Error", "Invalid documents Id");
      return;
    }
    return await db.delete(id!);
  }

  Stream<List<Komentar>> streamAllList() async* {
    yield* firebaseFirestore
        .collection(beritaCollection)
        .doc(beritaId)
        .collection(komentarCollection)
        .snapshots()
        .map((query) {
      List<Komentar> list = [];
      print("List");
      for (var doc in query.docs) {
        print(doc.reference);
        print(doc.data());
        list.add(
          Komentar.fromJson(
            doc,
          ),
        );
      }
      print("List length ${list.length}");
      return list;
    });
  }

  Stream<List<Komentar>> streamListFromBerita() async* {
    yield* db.collectionReference
        .orderBy("tanggal", descending: true)
        .snapshots()
        .map((query) {
      List<Komentar> list = [];
      for (var doc in query.docs) {
        list.add(
          Komentar.fromJson(
            doc,
          ),
        );
      }
      print('list l ${list.length}');
      return list;
    });
  }
}
