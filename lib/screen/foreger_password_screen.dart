import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'verifycode_screen.dart';
class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  static String id = " ForgetPasswordPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password',style: TextStyle(
            color: Colors.grey
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 25,),
            Text("Check Email",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
            SizedBox(height: 15,),
            Text("Please Enter Your Email Address To Recive A Verification Code ",textAlign: TextAlign.center,),
            SizedBox(height: 50,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: "Enter Your Email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                suffixIcon: Icon(Icons.email,color: Color(0xFF399679),),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            GestureDetector(child: Container(
              alignment: Alignment.center,
              width: 200,
              height:50,
              decoration: BoxDecoration( color: Color(0xFF399679),
                  borderRadius: BorderRadius.circular(100)),

              child: Text("Check",style: TextStyle(fontSize: 18,color: Colors.black),),
            ),
                onTap:(){
                  //Get.to(() => VerifyCode());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCode(),));
                })
          ],
        ),
      ),
    );
  }
}