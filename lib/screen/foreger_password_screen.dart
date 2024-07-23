import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/http.dart';
import 'verifycode_screen.dart';

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static String id = " ForgetPasswordPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password', style: TextStyle(
            color: Colors.grey
        )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 25,),
              Text("Check Email", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text("Please Enter Your Email Address To Receive A Verification Code", textAlign: TextAlign.center,),
              SizedBox(height: 50,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: "Enter Your Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  suffixIcon: Icon(Icons.email, color: Color(0xFF399679),),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(color: Color(0xFF399679),
                      borderRadius: BorderRadius.circular(100)),

                  child: Text("Check", style: TextStyle(fontSize: 18, color: Colors.black),),
                ),
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    ForgetPassword();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ForgetPassword() async {
    await HttpHelper.postData(url: 'password/email', body: {
      'email': _emailController.text,
    }).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        if (res.containsKey('message')) {
          Get.snackbar(
              'Success', res['message'].toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.black,
              colorText: Colors.white
          );
          Get.to(() => VerifyCode());
        } else {
          Get.snackbar(
              'Error', 'Unexpected response from server',
              backgroundColor: Colors.black,
              colorText: Colors.white
          );
        }
      } else {
        print(res);
        Get.snackbar(
            'Error', res['message'].toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white
        );
      }
    });
  }
}
