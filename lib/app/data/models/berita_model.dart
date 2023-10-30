import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/app/data/database.dart';
import 'package:connect_app/app/integrations/firestore.dart';
import 'package:nb_utils/nb_utils.dart';

class BeritaModel {
  String? id;
  String? judul;
  String? isi;
  String? image;
  String? kategori;
  int? like;
  DateTime? tanggal;
  List<String>? tags;

  BeritaModel({
    this.id,
    this.judul,
    this.isi,
    this.image,
    this.tanggal,
    this.kategori,
    this.like,
    this.tags,
  });

  // BeritaModel fromJson(DocumentSnapshot doc) {
  //   Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
  //   return BeritaModel(
  //     id: doc.id,
  //     judul: json[bjudul],
  //     isi: json[bisi],
  //     image: json[bimage],
  //     tanggal: (json[btanggal] as Timestamp?)?.toDate(),
  //   );
  // }

  BeritaModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>;
    id = doc.id;
    judul = json['judul'];
    isi = json['isi'];
    image = json['image'];
    tanggal = (json['tanggal'] as Timestamp?)?.toDate();
    kategori = json['kategori'];
    like = json['like'];
    tags = (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList();
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'judul': judul,
        'isi': isi,
        'image': image,
        'tanggal': tanggal,
        'kategori': kategori,
        'like': like,
        'tags': tags,
      };

  Database db = Database(
      collectionReference: firebaseFirestore.collection(
        beritaCollection,
      ),
      storageReference: firebaseStorage.ref(beritaCollection));

  Future<BeritaModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Future delete() async {
    (id == null) ? toast("Error Invalid ID") : await db.delete(id!, url: image);
  }

  Stream<List<BeritaModel>> streamList({int? limit}) async* {
    var query = db.collectionReference.orderBy("tanggal", descending: true);
    if (limit is int) {
      query = query.limit(limit);
    }
    yield* query.snapshots().map((query) {
      List<BeritaModel> list = [];
      for (var doc in query.docs) {
        list.add(
          BeritaModel.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
