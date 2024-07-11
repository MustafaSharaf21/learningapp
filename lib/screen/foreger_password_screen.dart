import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/generated/l10n.dart';

import 'verifycode_screen.dart';
class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  static String id = " ForgetPasswordPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).ForgetPassword,
        style: const TextStyle(
            color: Colors.grey
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 25,),
             Text(S.of(context).Check_Email,
            style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
            const SizedBox(height: 15,),
             Text(S.of(context).Please_Enter_Your_Email_Address_To_Recive_A_Verification_Code,textAlign: TextAlign.center,),
            const SizedBox(height: 50,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: S.of(context).email,
                hintText: S.of(context).Enter_Your_Email,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                suffixIcon: const Icon(Icons.email,color: Color(0xFF399679),),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            GestureDetector(child: Container(
              alignment: Alignment.center,
              width: 200,
              height:50,
              decoration: BoxDecoration( color:const Color(0xFF399679),
                  borderRadius: BorderRadius.circular(100)),

              child:Text(S.of(context).Check,style: const TextStyle(fontSize: 18,color: Colors.black),),
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