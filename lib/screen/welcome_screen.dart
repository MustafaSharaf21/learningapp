
import 'package:flutter/material.dart';
import 'package:learningapp/generated/l10n.dart';
import 'package:learningapp/service/service.dart';

import '../feuture/OnBoarding/presentation/on_boarding_view.dart';

class welcomeScreen extends StatefulWidget {
  static String id = " welcomeScreen";
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    goToNextView();
  }
  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration:const BoxDecoration(color: Colors.white),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration:const BoxDecoration(
                      color: Color(0xFF399679),
                      borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70)),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/IMG_20240304_182621_049.jpg",
                      scale: 0.02,
                      width: 250,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                // padding: EdgeInsets.only(top: 40,bottom: 30),
                decoration:const BoxDecoration(
                    // color: Color(0xFF674AEF),
                      color: Color(0xFF399679)

                    ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                padding:const EdgeInsets.only(top: 50, bottom: 30),
                decoration:const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                    )),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: fadingAnimation!,
                      child: Text(
                        S.of(context).Learning_is_Everything,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            wordSpacing: 2),
                      ),
                    ),
                      Padding(
                      padding:  const EdgeInsets.only(top:8,
                          left: 45,right: 35),
                      child: Text(S.of(context).Learning_with_pleasure_whenever_you_are,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff78787c)
                      ),),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingView(),
      ));
    });

  }
 }
