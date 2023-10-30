// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:connect_app/app/integrations/binding.dart';
import 'package:connect_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:connect_app/app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  InitBinding();
  WidgetsFlutterBinding.ensureInitialized();
  if (UniversalPlatform.isWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDqlb_RGwOyI5M8LiNK4HVS3CV4MicPQVk",
            authDomain: "connect-70b95.firebaseapp.com",
            projectId: "connect-70b95",
            storageBucket: "connect-70b95.appspot.com",
            messagingSenderId: "369652391610",
            appId: "1:369652391610:web:a1df7960f7dfdc79432c83"));
  } else {
    await Firebase.initializeApp();
  }
  FirebaseStorage.instance;
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuth(),
      builder: (context, s) {
        if (s.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''),
              Locale('id', ''),
            ],
            title: "CONNECT",
            initialRoute: s.data != null ? Routes.HOME : Routes.AUTH,
            getPages: AppPages.routes,
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: colorPrimary,
          ));
        }
      },
    );
  }
}
