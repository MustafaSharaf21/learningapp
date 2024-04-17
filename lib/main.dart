import 'package:flutter/material.dart';
import 'package:learningapp/screen/home_screen.dart';
import 'package:learningapp/screen/login_screen.dart';
import 'package:learningapp/screen/register1_screen.dart';
import 'package:learningapp/screen/register2_screen.dart';
import 'package:learningapp/screen/splash_screen.dart';

void main() {
  runApp(const LearningApp());//
}

class LearningApp extends StatefulWidget {
  const LearningApp({super.key});
  @override
  State<LearningApp> createState() => _LearningAppState();
}

class _LearningAppState extends State<LearningApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor:const  Color(0xFF399679
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterPage.id: (context) => RegisterPage(),
        RegisterPage2.id: (context) => RegisterPage2(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id:(context)=> HomePage(),
        SplashPage.id:(context)=> SplashPage(),
      },
      initialRoute:SplashPage.id,


    );
  }
}
//mmmmmmmmmmmmm