import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_and_vet/constance.dart';

import 'package:pet_and_vet/utils/translator/translation.dart';
import 'package:pet_and_vet/view/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      locale: Locale('ar'),
      fallbackLocale: Locale('ar'),
      title: 'Pet & Vet',
      theme: ThemeData(
        primaryColor: MyColors().primary,
        primaryColorDark: MyColors().primaryDark,
        // primarySwatch: MyColors().primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
