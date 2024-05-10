import 'package:flutter/material.dart';
import 'verifycode_screen.dart';
class ResetPassword extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  static String id = " ForgetPasswordPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password',style: TextStyle(
            color: Colors.grey
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 25,),
              Text("NewPassword",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text("Please Enter new Password",textAlign: TextAlign.center,),
              SizedBox(height: 50,),
              // OtpTextField(
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
              SizedBox(height: 35,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'password',
                  hintText: " PassWord",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  suffixIcon: Icon(Icons.lock,color: Color(0xFF399679),),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 27,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: ' Confirm password',
                  hintText: " Confirm  Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  suffixIcon: Icon(Icons.lock,color: Color(0xFF399679),),
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

                child: Text("Save",style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
                  onTap:(){

                  })
            ],
          ),
        ),
      ),
    );
  }
}