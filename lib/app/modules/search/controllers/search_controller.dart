import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController {
  var isSearching = false.obs;
  var emptyValue = false.obs;

  TextEditingController searchController = TextEditingController();
}
