// ignore_for_file: avoid_print, invalid_use_of_protected_member, unnecessary_overrides, prefer_final_fields

import 'package:connect_app/app/data/models/berita_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:nb_utils/nb_utils.dart';

class InputBeritaController extends GetxController {
  final GlobalKey<FormState> formberita = GlobalKey<FormState>();

  QuillController quillControllerisi = QuillController.basic();
  TextEditingController judulberitaC = TextEditingController();
  TextEditingController tagC = TextEditingController();
  var tags = <String>[].obs;
  var upMessage = ''.obs;
  GlobalKey<DropdownSearchState> tipeKategori = GlobalKey();
  Rxn<String> _selectedKategori = Rxn<String>();
  String? get selectedKategori => _selectedKategori.value;
  set selectedKategori(String? value) => _selectedKategori.value = value;

  var isSaving = false.obs;

  controllerToModel(BeritaModel berita) async {
    berita.isi = jsonEncode(quillControllerisi.document.toDelta().toJson());
    berita.judul = judulberitaC.text;
    if (berita.id == null) {
      berita.waktu = DateTime.now();
    }
    berita.tags = tags.value;
    berita.kategori = selectedKategori;
    berita.like = 0;
    return berita;
  }

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

  Future store(BeritaModel berita, {String? path}) async {
    isSaving.value = true;
    File? media;
    berita = await controllerToModel(berita);
    if (!path.isEmptyOrNull) {
      media = File(path!);
    }
    try {
      media == null ? await berita.save() : await berita.save(file: media);
      toast("Data Berhasil Diperbarui");
      Get.back();
    } catch (e) {
      print(e);
      toast("Error ${e.toString()}");
    } finally {
      isSaving.value = false;
    }
  }

  checkControllers(BeritaModel berita, String? path) {
    if (berita.id.isEmptyOrNull) {
      if (judulberitaC.text.isNotEmpty ||
          quillControllerisi.document.toDelta().toJson().isNotEmpty ||
          (path == null || path == '')) return true;
    } else {
      if (judulberitaC.text != berita.judul ||
          quillControllerisi.document.toDelta().toJson() !=
              jsonDecode(berita.isi ?? '') ||
          (path == null || path == '')) return true;
    }
    return false;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
