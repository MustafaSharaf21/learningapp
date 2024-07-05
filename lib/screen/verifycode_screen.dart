import 'package:flutter/material.dart';


class VerifyCode extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  static String id = " ForgetPasswordPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Verification Code ',style: TextStyle(
            color: Colors.grey
        )),
        centerTitle: true,
      ),
      body:const Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 25,),
            Text("Check Code",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
            SizedBox(height: 15,),
            Text("Please Enter The Digit Code Sent To Eline@gmail.com",textAlign: TextAlign.center,),
            SizedBox(height: 50,),
             //OtpTextField(
            //   focusedBorderColor: Color(0xFF399679),
            //   fieldWidth: 50,
            //   borderRadius: BorderRadius.circular(10),
            //   numberOfFields: 5,
            //   borderColor: Color(0xFF512DA8),
            //   //set to true to show as box or false to show as dash
            //   showFieldAsBox: true,
            //   //runs when a code is typed in
            //   onCodeChanged: (String code) {
            //     //handle validation or checks here
            //   },
            //   //runs when every textfield is filled
            //   onSubmit: (String verificationCode){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(),));
            //   }, // end onSubmit
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}