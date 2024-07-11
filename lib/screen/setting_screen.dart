/*
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learningapp/screen/profile/profile.dart';
import 'package:learningapp/screen/providers/provider.dart';
import 'package:learningapp/screen/shared/shared.dart';
import '../core/constants.dart';
import '../data/http.dart';
import '../generated/l10n.dart';
import 'login_screen.dart';
import 'my_constants.dart';
import 'profile/profile_screen.dart';
import 'package:provider/provider.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String dropdownValue = 'العربية' ;
  bool isSwitched= false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xFF399679),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                child: Container(child: Row(
                  children: [
                    Container(
                        width:27,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),child: Icon(Icons.person)),
                    SizedBox(width: 10,),
                    Text('My Account',style: TextStyle(color: Colors.black,fontSize: 18),),
                  ],
                ),
                  width: 335,
                  height: 50,
                  margin: EdgeInsets.only(left: 12,top: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xD5E5E4E4)
                  ),
                ),
                onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => profilepage(),));
                }),
            GestureDetector(
                child: Container(child: Row(
                  children: [
                    Container(
                        width:27,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),child: Icon(Icons.person)),
                    SizedBox(width: 10,),
                    Text('My Content',style: TextStyle(color: Colors.black,fontSize: 18),),
                  ],
                ),
                  width: 335,
                  height: 50,
                  margin: EdgeInsets.only(left: 12,top: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xD5E5E4E4)
                  ),
                ),
                onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => myContents(),));
                }),
            Container(
              width: 335,
              height: 50,
              margin: const EdgeInsets.only(left: 12,top: 8),
              padding:const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:const Color(0xD5E5E4E4)
                      ),
               child: Row(
                children: [
                  Container(
                      width:27,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)
                      ),child: const Icon(Icons.language)),
                  const SizedBox(width: 10,),
                  const Text(' App Language',style: TextStyle(color: Colors.black,fontSize: 18),),
                  const SizedBox(width: 72,),
                  DropdownButton<String>( value:dropdownValue,
                      icon:const Icon(Icons.arrow_drop_down),items: const [
                        DropdownMenuItem( value:'العربية',child: Text('العربية')),
                        DropdownMenuItem( value:'English',child: Text('English')),
                      ], onChanged: (String?newValue){
                        setState(() {
                          dropdownValue=newValue!;
                        });
                      })
                ],
              ),
            ),
            Container(
              child: Row(
              children: [
                Container(
                    width:27,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)
                    ),child: Icon(Icons.dark_mode_rounded)),
                SizedBox(width: 10,),
                Text('Dark Mood',style: TextStyle(color: Colors.black,fontSize: 18),),
                SizedBox(width: 122,),
                Transform.scale(scale: 0.7,
                  child: Switch(activeColor:Color(0xFF399679),value:isSwitched, onChanged: (bool value) { setState(() {
                    isSwitched=value;

                  }); },),
                )
              ],
            ),
              width: 335,
              height: 50,
              margin: EdgeInsets.only(left: 12,top: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xD5E5E4E4)
              ),
            ),
            Container(
              width: 335,
              height: 60,
              margin: EdgeInsets.all(5),
              child: ListTile(
                trailing: Icon(Icons.logout,color: Color(0xff10AB9E),),
                onTap: () {
                  Get.defaultDialog(
                      title: 'Are you sure to log out?',
                      content: Container(),
                      cancelTextColor: Color(0xff10AB9E),
                      textConfirm: 'confirm',
                      buttonColor: Color(0xff10AB9E),
                      textCancel: 'cancel',
                      confirmTextColor: Colors.white,
                      onConfirm: () async {
                        await http.post(Uri.parse(
                            'http://192.168.43.63:8000/api/logout'),
                            headers: {
                              'Authorization':'Bearer $token'
                            }
                        ).then((value) {

                          Map<String,dynamic>res =jsonDecode(value.body);
                          print(res['data']);
                          print(token);
                          if(value.statusCode==200||value.statusCode==201){
                            Get.snackbar(
                                'signed out',res['data'],
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.black,
                                colorText: Colors.white);
                             Get.offAll(()=>LoginPage());

                          }else {
                            print(res);
                            print(token);
                          }
                        });

                      },onCancel: (){
                    Get.back();
                  }

                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.grey[300],
                title: Text(
                  'log out',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'click here to log out',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"),
                        )
                      ],
                      title: Text("Language"),
                      contentPadding: EdgeInsets.all(20),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () async {
                                Provider.of<dProvider>(context, listen: false)
                                    .setLanguage('ar');
                                await CacheNetwork.insertToCache(
                                    key: 'language', value: "ar");
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Arabic",
                                style: TextStyle(color: Kcolor),
                              )),
                          TextButton(
                              onPressed: () async {
                                Provider.of<dProvider>(context, listen: false)
                                    .setLanguage('en');
                                await CacheNetwork.insertToCache(
                                    key: 'language', value: "en");
                                Navigator.pop(context);
                              },
                              child: Text(
                                "English",
                                style: TextStyle(color:Kcolor),
                              ))
                        ],
                      ),
                    ));
              },
              leading: Icon(FontAwesomeIcons.language),
              title: Text(
               " Language",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
*/


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learningapp/generated/l10n.dart';
import 'package:learningapp/screen/add_course_page/add_course_page.dart';
import 'package:learningapp/screen/profile/profile.dart';
import 'package:learningapp/screen/providers/provider.dart';
import 'package:learningapp/screen/shared/shared.dart';
import 'package:provider/provider.dart';
import '../const.dart';
import '../core/constants.dart';
import '../data/http.dart';
import 'login_screen.dart';
import 'my_constants.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String dropdownValue = 'العربية' ;
  bool isSwitched= false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(S.of(context).Setting,
        style: const TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xFF399679),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                child: Container(
                  child: Row(
                  children: [
                    Container(
                        width:27,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),child: Icon(Icons.person)),
                    SizedBox(width: 10,),
                    Text(S.of(context).My_Account,
                    style: TextStyle(color: Colors.black,fontSize: 18),),
                  ],
                ),
                  width: 335,
                  height: 50,
                  margin: const EdgeInsets.only(left: 12,top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xD5E5E4E4)
                  ),
                ),
                onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const profilepage(),));
                }),
            box.read('role')!='2'?Container(): GestureDetector(

                child: Container(
                  child: Row(
                  children: [
                    Container(
                        width:27,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),child: Icon(Icons.add)),
                    SizedBox(width: 10,),
                    Text(S.of(context).Add_course,
                    style: TextStyle(color: Colors.black,fontSize: 18),),
                  ],
                ),
                  width: 335,
                  height: 50,
                  margin: const EdgeInsets.only(left: 12,top: 8,right: 12,),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xD5E5E4E4)
                  ),
                ),
                onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCoursesPage(),));
                }),
            box.read('role')!='2'?Container(): GestureDetector(
                child: Container(
                  child: Row(
                  children: [
                    Container(
                        width:27,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),child: Icon(Icons.person)),
                    SizedBox(width: 10,),
                    Text(S.of(context).My_content,style: TextStyle(color: Colors.black,fontSize: 18),),
                  ],
                ),
                  width: 335,
                  height: 50,
                  margin: const EdgeInsets.only(left: 12,top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xD5E5E4E4)
                  ),
                ),
                onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const myContents(),));
                }),
            Container(
              width: 335,
              height: 50,
              margin: const EdgeInsets.only(left: 12,top: 8),
              //padding: const EdgeInsets.only(left: ,),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xD5E5E4E4)
              ),
              child:  ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(S.of(context).Close),
                          )
                        ],
                        title: Text(S.of(context).Language),
                        contentPadding: const EdgeInsets.all(20),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Provider.of<dProvider>(context, listen: false)
                                    .setLanguage('ar');
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text(
                                S.of(context).Arabic,
                                style: const TextStyle(color: Kcolor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<dProvider>(context, listen: false)
                                    .setLanguage('en');
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text(
                                S.of(context).English,
                                style: const TextStyle(color: Kcolor),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  leading: const Icon(FontAwesomeIcons.language),
                  title: Text(
                    S.of(context).Language,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),

            Container(
              width: 335,
              height: 50,
              margin: const EdgeInsets.only(left: 12,top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xD5E5E4E4)
              ),
              child: Row(
              children: [
                Container(
                    width:27,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: const Icon(Icons.dark_mode_rounded)),
                const SizedBox(width: 10,),
                Text(S.of(context).Dark_Mood,
                style: const TextStyle(color: Colors.black,fontSize: 18),),
                const SizedBox(width: 122,),
                Transform.scale(scale: 0.7,
                  child: Switch(activeColor:const Color(0xFF399679),
                  value:isSwitched, onChanged: (bool value) { setState(() {
                    isSwitched=value;

                  }); },),
                )
              ],
            ),
            ),
            Container(
              width: 335,
              height: 60,
              margin: const EdgeInsets.all(5),
              child: ListTile(
                trailing: const Icon(Icons.logout,color: Color(0xff10AB9E),),
                onTap: () {
                  Get.defaultDialog(
                      title: S.of(context).Are_you_sure_to_log_out,
                      content: Container(),
                      cancelTextColor: const Color(0xff10AB9E),
                      textConfirm: S.of(context).confirm,
                      buttonColor: const Color(0xff10AB9E),
                      textCancel: S.of(context).cancel,
                      confirmTextColor: Colors.white,
                      onConfirm: () async {
                        await http.post(Uri.parse(
                            'http://192.168.118.128:8000/api/logout'),
                            headers: {
                              'Authorization':'Bearer $token'
                            }
                        ).then((value) {

                          Map<String,dynamic>res =jsonDecode(value.body);
                          print(res['data']);
                          print(token);
                          if(value.statusCode==200||value.statusCode==201){
                            Get.snackbar(
                                'signed out',res['data'],
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.black,
                                colorText: Colors.white);
                            Get.offAll(()=>LoginPage());

                          }else {
                            print(res);
                            print(token);
                          }
                        });

                      },onCancel: (){
                    Get.back();
                  }

                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.grey[300],
                title: Text(
                  S.of(context).log_out,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  S.of(context).click_here_to_log_out,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<dProvider>(context, listen: false)
                    .setLanguage('ar');
                setState(() {});
                //Navigator.pop(context);
              },
              child: Text(
                S.of(context).Arabic,
                style: const TextStyle(color: Kcolor),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<dProvider>(context, listen: false)
                    .setLanguage('en');
                setState(() {});
                //Navigator.pop(context);
              },
              child: Text(
                S.of(context).English,
                style: const TextStyle(color: Kcolor),
              ),
            )

          ],
        ),
      ),
    );
  }

}


/* Row(
                children: [
                  Container(
                      width:27,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(Icons.language)),
                  SizedBox(width: 10,),
                  Text(' App Language',style: TextStyle(color: Colors.black,fontSize: 18),),
                  SizedBox(width: 72,),
                  DropdownButton<String>( value:dropdownValue,
                      icon:Icon(Icons.arrow_drop_down),items: [
                        DropdownMenuItem( value:'العربية',child: Text('العربية')),
                        DropdownMenuItem( value:'English',child: Text('English')),
                      ], onChanged: (String?newValue){
                        setState(() {
                          dropdownValue=newValue!;
                        });
                      })
                ],
              ),*/
