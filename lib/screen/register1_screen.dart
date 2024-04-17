import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/screen/register2_screen.dart';
import 'package:lottie/lottie.dart';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../core/widgets/header_painater.dart';



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
  bool secureText = true,secureText2 = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String>genderList=['Teacher','Student'];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Color(0xFFB2CCC8),],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
          ),
        ),
        child:ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [Form(
            key: _formkey,
            child: Column(
              children:[
                FullHeaderPainter(HeaderText: "Register"),
                const SizedBox(height: 200,),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: Kcolor
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText("Do you want to Register as Teacher or Student ?"),
                    ],
                  ),
                ),
                Container(
                  width: 325,
                  height: 65,
                  decoration:BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left:10,top: 5),
                        child:Icon(Icons.person,color: Color(0xFF413F3F)) ,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10,top: 5),
                        child:DropdownButton(
                          borderRadius: BorderRadius.circular(30),
                          underline:const Divider( thickness:0,height:0),
                          icon:const Icon(Icons.arrow_drop_down, color: Color(0xFF464241),size: 30,),
                          dropdownColor: Kcolor,
                          hint:const  Text(
                            'Choose Teacher or Student              ',
                            style: TextStyle(
                                fontSize:15,
                                color: Color(0xFF464241),
                                fontFamily:'Cairo'),
                          ),
                          items:genderList.map((item) =>DropdownMenuItem(
                            value: item,
                            child: Text(item,
                              style:const  TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily:'Cairo'),
                            ),
                          ),
                          ).toList(),
                          onChanged: (item){
                            setState((){
                              selectedGender=item;
                              // print( selectedGender);
                            });
                          },
                          value: selectedGender,

                        ) ,),
                    ],
                  ),

                ),
                const  SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 30, right: 30,),
                  child: TextFormField(
                    controller: full_Name,
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.person, "Full Name"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter an name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: buildInputDecoration(Icons.email, "Email"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter an email';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Enter a valid Email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                    obscureText: secureText,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secureText = !secureText;
                            });
                          },
                          icon: Icon(secureText ? Icons.visibility_off : Icons.visibility)),
                      prefixIcon: const Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color:Kcolor, width: 1),
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
                        return 'Enter a Password';
                      }
                      if(value.length<6){
                        return 'Password must be greater than six characters';

                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: secureText2,
                    controller: confirmpassword,
                    decoration: InputDecoration(
                      labelText:"Confirm Password" ,
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secureText2 = !secureText2;
                            });
                          },
                          icon: Icon(secureText2 ? Icons.visibility_off : Icons.visibility)),
                      prefixIcon: const Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color:Kcolor,
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
                        return 'Re-enter Password';
                      }
                      print(password.text);

                      print(confirmpassword.text);

                      if (password.text != confirmpassword.text) {
                        return "Enter the Password Correctly";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    if (_formkey.currentState!.validate()){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return RegisterPage2();
                          }));
                    }
                  },
                  child:Padding(
                      padding:const EdgeInsets.symmetric(horizontal:80.0 ) ,
                      child: Lottie.asset('assets/images/next2.json',height:150,width:150,)
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
}

/*

Align(
child: IconButton(
style: IconButton.styleFrom(
shape: const OvalBorder(),
backgroundColor:  Kcolor,
),
onPressed: () {
if (_formkey.currentState!.validate()) {
Navigator.push(context,
MaterialPageRoute(builder: (context) {
return RegisterPage2();
}));
}
},
icon: const Icon(
Icons.east_sharp,
size: 25,
color: Colors.grey,
),
),
),*/
