// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:connect_app/app/integrations/binding.dart';
import 'package:connect_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  InitBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseStorage.instance;
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
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
      theme: ThemeData(fontFamily: 'Nunito'),
      localizationsDelegates: [
        // AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('id', ''), // Indonesian, no country code
      ],
      debugShowCheckedModeBanner: false,
      title: "CONNECT",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    );
  }
}
