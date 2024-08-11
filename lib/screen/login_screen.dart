import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/core/widgets/buildInputDecoration.dart';
import 'package:learningapp/core/widgets/header_painater.dart';
import '../data/http.dart';
import '../data/models/Getx_Controller.dart';
import '../generated/l10n.dart';
import 'foreger_password_screen.dart';
import 'home_screen.dart';
import 'register1_screen.dart';

class LoginPage extends StatefulWidget {
  static String id = " LoginPage";
  @override //
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool secureText = true;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    print(credential);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Color(0xFFE0F5EC),
              ], //Color(0xFFBCF3E2)
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: ListView(
          children: [
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FullHeader(HeaderText: S.of(context).titleLogin),
                  const SizedBox(
                    height: 180,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 30, right: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: buildInputDecoration(context,
                          Icons.email, S.of(context).email),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).enter_an_email;
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return S.of(context).enter_a_valid_Email;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 30, right: 30),
                    child: TextFormField(
                      obscureText: secureText,
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: S.of(context).password,
                        hintText: S.of(context).password,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                secureText = !secureText;
                              });
                            },
                            icon: Icon(secureText
                                ? Icons.visibility_off
                                : Icons.visibility), color: iconColor),
                        prefixIcon:  Icon(Icons.lock, color: iconColor),
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
                          return S.of(context).enter_a_password;
                        }
                        if (value.length < 6) {
                          return S.of(context).Password_characters;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.only(right: 20),
                      child:  Text(
                        S.of(context).ForgetPassword,
                        style: const TextStyle(color: Colors.grey),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordPage(),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 80.0),
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: const BoxDecoration(
                            color: Kcolor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            )),
                        child:  Center(
                          child: Text(
                            S.of(context).titleLogin,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).Login_with_Facebook_or_Google,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              print("object");
                            },
                            child: const Icon(
                              FontAwesomeIcons.facebook,
                              color: Color(0xFF1877f2),
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              await signInWithGoogle();
                            },
                            child: const Icon(
                              FontAwesomeIcons.google,
                              color: Color(0xFFdb4437),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).If_you_dont_have_an_account,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterPage();
                      }));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).titleRegister,
                              style: const TextStyle(
                                color: Kcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Cairo',
                              )),
                        ]),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() async {

    await HttpHelper.postData(
        url: 'login',
        body: {'email': email.text, 'password': password.text}).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
       /* print( res['data']['role_id ']);
        print(res['data']['token']);*/
        token = res['data']['token'];
        GetStorage _box = GetStorage();
        _box.write('token', token);
        int roleId = res['data']['role_id '];
        Get.find<UserRoleController>().setRoleId(roleId);
        print('Login roleId -------------------: $roleId');
        Get.snackbar(' ', res['data']['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Kcolor,
            colorText: Colors.white);
        print(res);
        print(token);
        //Get.to(MyHomePage());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyHomePage(),));
      } else {
        print(res);
        Get.snackbar('Error', res['message'].toString(),
            backgroundColor: Colors.black, colorText: Colors.white);
      }
    });
  }


  /*login() async {
    await HttpHelper.postData(
        url: 'login',
        body: {'email': email.text, 'password': password.text}
    ).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res['data']['token'];
        GetStorage _box = GetStorage();
        _box.write('token', token);

        // تأكد من أن role_id ليس null
        if (res['data']['role_id'] != null) {
          int roleId = res['data']['role_id'];
          Get.find<UserRoleController>().setRoleId(roleId);
        } else {
          // التعامل مع الحالة التي يكون فيها role_id غير موجود أو null
          // يمكنك إما تعيين قيمة افتراضية أو إظهار رسالة خطأ
          Get.snackbar('Error', 'Role ID is missing.',
              backgroundColor: Colors.black,
              colorText: Colors.white
          );
          return;
        }

        Get.snackbar(' ', res['data']['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Kcolor,
            colorText: Colors.white
        );
        print(res);
        print(token);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyHomePage())
        );
      } else {
        print(res);
        Get.snackbar('Error', res['message'].toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white
        );
      }
    });
  }*/




}
