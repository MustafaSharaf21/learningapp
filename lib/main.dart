import 'package:flutter/material.dart';
import 'package:learningapp/screen/home_page.dart';
import 'package:learningapp/screen/welcomeScreen.dart';

void main() {
  runApp(const MyApp());//mustafa
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:welcomeScreen()
    );
  }
}

