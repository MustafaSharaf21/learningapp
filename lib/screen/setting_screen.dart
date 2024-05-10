import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../data/http.dart';
import 'login_screen.dart';
import 'my_constants.dart';
import 'profile/profile_screen.dart';

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
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
            Container(width: 335,
              height: 50,
              margin: EdgeInsets.only(left: 12,top: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xD5E5E4E4)
              ),child: Row(
                children: [
                  Container(
                      width:27,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)
                      ),child: Icon(Icons.language)),
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
              ),
            ),
            Container(child: Row(
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
          ],
        ),
      ),
    );
  }

}
