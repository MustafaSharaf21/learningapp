import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:learningapp/screen/login_screen.dart';
import '../data/http.dart' as http;
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  static String id = " ForgetPasswordPage";

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController pass = TextEditingController();
  String verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle(
          color: Colors.grey,
        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              Text("New Password", style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600,
              )),
              SizedBox(height: 15),
              Text("Please Enter new Password", textAlign: TextAlign.center),
              SizedBox(height: 50),
              OtpTextField(
                focusedBorderColor: Color(0xFF399679),
                fieldWidth: 50,
                borderRadius: BorderRadius.circular(10),
                numberOfFields: 5,
                borderColor: Color(0xFF512DA8),
                showFieldAsBox: true,
                onCodeChanged: (String code) {
                  // handle validation or checks here
                },
                onSubmit: (String code) {
                  verificationCode = code;
                },
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: pass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  suffixIcon: Icon(Icons.lock, color: Color(0xFF399679)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 27),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF399679),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text("Save", style: TextStyle(fontSize: 18, color: Colors.black)),
                ),
                onTap: () {
                  resetPassword(verificationCode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword(String code) async {
    await http.HttpHelper.postData(url: 'password/reset', body: {
      'code': code,
      'password': pass.text,
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
          Get.to(() => LoginPage());
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
