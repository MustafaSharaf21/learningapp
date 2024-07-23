import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../data/http.dart';
import 'resetpassword_screen.dart';

class VerifyCode extends StatelessWidget {
  static String id = " ForgetPasswordPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification Code',
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 25,),
            Text(
              "Check Code",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 15,),
            Text(
              "Please Enter The Digit Code Sent To Eline@gmail.com",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            OtpTextField(
              focusedBorderColor: Color(0xFF399679),
              fieldWidth: 50,
              borderRadius: BorderRadius.circular(10),
              numberOfFields: 5,
              borderColor: Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                // Handle validation or checks here if needed
              },
              onSubmit: (String verificationCode) {
                Verification(verificationCode);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Verification(String code) async {
    await HttpHelper.postData(url: 'password/code/check', body: {
      'code': code, // إرسال رمز التحقق
    }).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        if (res.containsKey('message')) {
          Get.snackbar(
            'Success', res['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
          );
          Get.to(() => ResetPassword());
        } else {
          Get.snackbar(
            'Error', 'Unexpected response from server',
            backgroundColor: Colors.black,
            colorText: Colors.white,
          );
        }
      } else {
        print(res);
        Get.snackbar(
          'Error', res['message'].toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    });
  }
}
