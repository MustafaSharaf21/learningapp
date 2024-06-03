import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/generated/l10n.dart';
import 'package:learningapp/screen/home_screen.dart';
import 'package:learningapp/screen/login_screen.dart';
import 'package:learningapp/screen/profile/profile.dart';
import 'package:learningapp/screen/profile/profile_screen.dart';
import 'package:learningapp/screen/register1_screen.dart';
import 'package:learningapp/screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learningapp/screen/testMySelf/creat_questions.dart';

import 'screen/category_screen.dart';
import 'screen/profile/update_profile_screen.dart';
import 'screen/testMySelf/test_myself.dart';



void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatefulWidget {
  const LearningApp({super.key});
  @override
  State<LearningApp> createState() => _LearningAppState();
}

class _LearningAppState extends State<LearningApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor:const  Color(0xFF399679
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Profile.id: (context) => Profile(),
        profilepage.id: (context) => profilepage(),
        RegisterPage.id: (context) => RegisterPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id:(context)=> HomePage(),
        SplashPage.id:(context)=> SplashPage(),
        Category.id:(context)=> Category(),
       // CreatQuestion.id:(context)=> CreatQuestion(),
        TestMySelf.id:(context)=> TestMySelf(),
      },
      initialRoute:LoginPage.id,
      locale: Locale('en'),
      localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,


    );
  }
}
//mmmm