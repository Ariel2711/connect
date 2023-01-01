// ignore_for_file: prefer_final_fields, invalid_use_of_protected_member, avoid_print

import 'dart:convert';

import 'package:connect_app/app/data/models/berita_model.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var currentPos = 0;

  QuillController quillControllerisi = QuillController.basic();
  TextEditingController judulberitaC = TextEditingController();
  TextEditingController tagC = TextEditingController();
  var tags = <String>[].obs;
  var upMessage = ''.obs;

  Rxn<String> _selectedKategori = Rxn<String>();
  String? get selectedKategori => _selectedKategori.value;
  set selectedKategori(String? value) => _selectedKategori.value = value;

  RxList<BeritaModel> rxBerita = RxList<BeritaModel>();
  List<BeritaModel> get listberita => rxBerita.value;
  set listberita(List<BeritaModel> value) => rxBerita.value = value;

  modelToController(BeritaModel berita) {
    if (berita.id != null && berita.judul != null && berita.isi != null) {
      judulberitaC.text = berita.judul ?? '';
      Document documentisi = Document.fromJson(jsonDecode(berita.isi ?? ''));
      if (berita.tags?.isNotEmpty ?? false) {
        tags.value = berita.tags!;
      }
      quillControllerisi = QuillController(
          document: documentisi, selection: TextSelection.collapsed(offset: 0));
      selectedKategori = berita.kategori ?? '';
    } else {
      print("not found model berita");
    }
  }

  String getPlainQuill(String? value) {
    if (value == null || value == '') return '';
    Document doc = Document.fromJson(jsonDecode(value));
    return doc.toPlainText();
  }

  @override
  void onInit() {
    rxBerita.bindStream(BeritaModel().streamList());
    super.onInit();
  }
}
