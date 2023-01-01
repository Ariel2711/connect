import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/widgets/appbar.dart';
import 'package:connect_app/app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffold,
      appBar: appBarWidget(
        title: "Profil User",
        isWithLogo: true,
      ),
      body: Center(
        child: Text(
          'ProfilView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNav(
        initialindex: 2,
      ),
    );
  }
}
