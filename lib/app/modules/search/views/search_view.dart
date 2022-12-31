import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffold,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorWhite,
                      suffixIcon: controller.isSearching.value
                          ? IconButton(
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                controller.searchController.clear();
                              },
                              icon: Icon(Icons.cancel_outlined))
                          : Icon(
                              Icons.search,
                              color: colorPrimary,
                            ),
                      hintText: "Cari berita",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(26)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        initialindex: 1,
      ),
    );
  }
}
