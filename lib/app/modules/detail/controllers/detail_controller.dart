// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'dart:convert';

import 'package:connect_app/app/data/models/berita_model.dart';
import 'package:connect_app/app/data/models/komentar_model.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DetailController extends GetxController {
  QuillController quillControllerisi = QuillController.basic();
  TextEditingController komentarC = TextEditingController();

  String? beritaId;

  var isSaving = false.obs;

  RxList<Komentar> rxkomentar = RxList<Komentar>();
  List<Komentar> get listkomentar => rxkomentar.value;
  set listkomentar(List<Komentar> value) => rxkomentar.value = value;

  modelToController(BeritaModel berita) {
    beritaId = berita.id;
    rxkomentar.bindStream(Komentar(beritaId: beritaId).streamAllList());
    if (berita.id != null && berita.judul != null && berita.isi != null) {
      Document documentisi = Document.fromJson(jsonDecode(berita.isi ?? ''));
      quillControllerisi = QuillController(
          document: documentisi, selection: TextSelection.collapsed(offset: 0));
    } else {
      print("not found model berita");
    }
  }

  Future store(Komentar komentar, BeritaModel berita) async {
    isSaving.value = true;
    komentar.isi = komentarC.text;
    komentar.beritaId = berita.id;
    komentar.tanggal = DateTime.now();
    try {
      await komentar.save();
      toast("Data Berhasil Diperbarui");
      Get.back();
    } catch (e) {
      print(e);
      toast("Error ${e.toString()}");
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
