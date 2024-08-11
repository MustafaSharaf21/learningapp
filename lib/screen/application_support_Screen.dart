import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../generated/l10n.dart';
import 'login_screen.dart';


class ApplicationSupport extends StatefulWidget {
  static String id = "SplashPage";
  const ApplicationSupport({super.key});

  @override
  State<ApplicationSupport> createState() => _ApplicationSupportState();
}

class _ApplicationSupportState extends State<ApplicationSupport> {
  TextEditingController Enter_message = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                padding:const EdgeInsets.only(left: 150,right: 150,bottom:20) ,
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
              const SizedBox(height: 150,),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15, left: 30, right: 30,),
                child: TextFormField(
                  controller: Enter_message,
                  keyboardType: TextInputType.text,
                  decoration: buildInputDecoration(context,Icons.message,"Enter Message"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Message";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    //login();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 80.0),
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: const BoxDecoration(
                        color: Kcolor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        )),
                    child:  Center(
                      child: Text(
                        "send",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}



