import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../generated/l10n.dart';
import 'login_screen.dart';


class SplashPage extends StatefulWidget {
  static String id = "SplashPage";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 4),
            () => Navigator.pushReplacementNamed(
            context,  LoginPage.id));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Color(0xFF96D5C1),],//Color(0xFFBCF3E2)
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
          ),
        ),
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:const EdgeInsets.only(left: 140,right: 140,bottom:20) ,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/logo_img.png',
                  ),
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Kcolor
                ),
                child: AnimatedTextKit(
                  pause:const  Duration(seconds:4),
                  animatedTexts: [
                    WavyAnimatedText(S.of(context).name),

                  ],
                  isRepeatingAnimation: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



