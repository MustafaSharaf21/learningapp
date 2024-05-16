import 'dart:convert';
import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learningapp/screen/home_screen.dart';
import 'package:learningapp/screen/register2_screen.dart';
import 'package:lottie/lottie.dart';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../core/widgets/header_painater.dart';
import '../data/http.dart';
import '../generated/l10n.dart';
import 'package:http/http.dart' as http;



class RegisterPage extends StatefulWidget {
  static String id = "RegisterPage";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController full_Name = TextEditingController();
  TextEditingController Student_or_teacher = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController idd = TextEditingController();
  bool secureText = true,
      secureText2 = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //List<String>genderList=['Teacher','Student'];
  final Map<String, int>roles = {'Student': 3, 'Teacher': 2};
  String? selectedGender;
  String? selectedRole;
  int? selectedRoleId;

// @override
// void dispose(){
//   full_Name.dispose();
//   email.dispose();
//   password.dispose();
//   confirmpassword.dispose();
//   super.dispose();
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Color(0xFFB2CCC8),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
          ),
        ),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [Form(
            key: _formkey,
            child: Column(
              children: [
                FullHeaderPainter(HeaderText: S
                    .of(context)
                    .titleRegister),
                const SizedBox(height: 50),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: Kcolor
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(S
                          .of(context)
                          .Teacher_or_Student),
                    ],
                  ),
                ),
                Container(
                  width: 325,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Icon(Icons.person, color: Color(0xFF413F3F)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(30),
                          // underline:const Divider( thickness:0,height:0),
                          icon: const Icon(
                            Icons.arrow_drop_down, color: Color(0xFF464241),
                            size: 30,),
                          dropdownColor: Kcolor,
                          hint: Text(
                            S
                                .of(context)
                                .Choose_Teacher_or_Student,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF464241),
                                fontFamily: 'Cairo'),
                          ),
                          items: roles.entries.map((entry) {
                            return
                              DropdownMenuItem<String>(
                                value: entry.key.toString(),
                                child: Text(entry.key,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Cairo'),
                                ),
                              );
                          }).toList(),
                          onChanged: (String?newValue) {
                            setState(() {
                              selectedRole = newValue;
                              selectedRoleId = roles[newValue];
                              idd.text=selectedRoleId.toString();
                              print(
                                  'Selected role: $selectedRole, ID: $selectedRoleId');
                            });
                          },
                          value: selectedRole,

                        ),),
                    ],
                  ),

                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15, left: 30, right: 30,),
                  child: TextFormField(
                    controller: full_Name,
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.person, S
                        .of(context)
                        .Full_Name),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .Enter_a_name;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: buildInputDecoration(Icons.email, S
                        .of(context)
                        .email),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .enter_an_email;
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return S
                            .of(context)
                            .enter_a_valid_Email;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                    obscureText: secureText,
                    decoration: InputDecoration(
                      labelText: S
                          .of(context)
                          .password,
                      hintText: S
                          .of(context)
                          .password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secureText = !secureText;
                            });
                          },
                          icon: Icon(secureText ? Icons.visibility_off : Icons
                              .visibility)),
                      prefixIcon: const Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Kcolor, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .enter_a_password;
                      }
                      if (value.length < 6) {
                        return S
                            .of(context)
                            .Password_characters;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: secureText2,
                    controller: confirmpassword,
                    decoration: InputDecoration(
                      labelText: S
                          .of(context)
                          .Confirm_Password,
                      hintText: S
                          .of(context)
                          .Confirm_Password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secureText2 = !secureText2;
                            });
                          },
                          icon: Icon(secureText2 ? Icons.visibility_off : Icons
                              .visibility)),
                      prefixIcon: const Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Kcolor,
                            width: 1
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .Reenter_Password;
                      }
                      print(password.text);

                      print(confirmpassword.text);

                      if (password.text != confirmpassword.text) {
                        return S
                            .of(context)
                            .Enter_the_Password_Correctly;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signup();
                  Get.to(

                    RegisterPage2()
                  );
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: Lottie.asset(
                        'assets/images/next2.json', height: 150, width: 150,)
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }

  // Future<void> signup1() async {
  // String apiUrl='http://192.168.43.63:8000/api/register';
  // int? id = roles[selectedGender];
  // try{
  //   var response = await http.post(Uri.parse(apiUrl),
  //   body: json.encode({
  //     'name':full_Name.text,
  //     'email':email.text,
  //     'password':password.text,
  //     'confirm_password':confirmpassword.text,
  //     'role_id':id
  //   }),
  //   );
  //   if (response.statusCode==200){
  //     print('User registered successfully');
  //     navigatorToRegister2();
  //   }else{
  //     print(res);
  //     print('Failed to register user');
  //   }
  // }catch(e){
  //   print(e.toString());
  // }
  // }
  signup() async {
    int? id = roles[selectedGender];
    await HttpHelper.postData(url: 'register', body: {
      'name': full_Name.text,
      'email': email.text,
      'password': password.text,
      'confirm_password': confirmpassword.text,
      'role_id': idd.text
    }).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res['data']['token'];
        GetStorage _box = GetStorage();
        _box.write('token', token);
        Get.snackbar(
            ' ', res['status'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white
        );
        print(res);
        print(token);
        Get.to((RegisterPage2()));
      } else {
        print(res);
        Get.snackbar(
            'Error', res['status'].toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white

        );
      }
    });
//   }
//   Future<void> navigatorToRegister2() async{
//   if(selectedGender!=null){
//     int roleId=roles[selectedGender]!;
//     Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage2(
//       email: email.text,
//       name: full_Name.text,
//       pass: password.text,
//       confirmpass: confirmpassword.text,
//       //roleId: selectedRoleId,
//     ),));
//   }else{
//     print('select the role please');
//     }
// }
  }

}