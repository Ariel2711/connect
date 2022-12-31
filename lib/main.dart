import 'package:connect_app/app/integrations/binding.dart';
import 'package:connect_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  InitBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseStorage.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<User?>(
    //   stream: authC.streamAuth(),
    //   builder: (context, s) {
    //     if (s.connectionState == ConnectionState.active) {
    //       return GetMaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         title: "CONNECT",
    //         initialRoute: s.data != null ? Routes.HOME : Routes.AUTH,
    //         getPages: AppPages.routes,
    //       );
    //     }
    //   },
    // );
    return GetMaterialApp(
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: primary,
      //     elevation: 0,
      //   ),
      //   bottomAppBarColor: primary,
      //   floatingActionButtonTheme:
      //       FloatingActionButtonThemeData(backgroundColor: primary),
      // ),
      debugShowCheckedModeBanner: false,
      title: "CONNECT",
      initialRoute: Routes.AUTH,
      getPages: AppPages.routes,
    );
  }
}
