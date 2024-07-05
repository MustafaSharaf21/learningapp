import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/http.dart';
import 'update_profile_screen.dart';
import 'widgets/profile_menu.dart';

class Profile extends StatefulWidget {
  static String id = "Profile";
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map <String,dynamic> prof={};
  @override
  void initState() {

    fetchUserProfile();


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Profile'),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){},),
      ),
      body: ListView(
          children:[Container(padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: 120,
                        height: 120,
                        child:ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.network(prof['data']['image']))
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFF399679),
                        ),
                        child: const Icon(Icons.edit_outlined,size: 15,),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Text(prof['data']['name'],style: TextStyle(fontFamily: 'Pacifico'),),
                SizedBox(height: 10,),
                SizedBox(width:150,child:  ElevatedButton(onPressed: ()=>Get.to(()=>UpdateProfileScreen()), child: const Text("Edit Profile") )),
                const SizedBox(height: 2.5,),
                const Divider(color: Color(0xC7EAEAEA),),
                const SizedBox(height: 5,),
                ProfileMenuWidget(title:"Name ",icon:Icons.person,onpress: (){}, subtitle: prof['data']['name'], height: 57,),
                SizedBox(height: 14,),
                ProfileMenuWidget(title:"Email",icon:Icons.email,onpress: (){}, subtitle: prof['data']['email'], height: 57),
                SizedBox(height: 14,),
                ProfileMenuWidget(title:"Phone",icon:Icons.phone,
                  onpress: (){}, subtitle: prof['data']['phone'], height: 57),
                SizedBox(height: 14,),
                ProfileMenuWidget(title:"Gender",icon:Icons.wc,
                  onpress: (){}, subtitle: prof['data']['gender'], height: 57),
                SizedBox(height: 14,),
                ProfileMenuWidget(title:"Birth_Date",icon:Icons.celebration,
                  onpress: (){}, subtitle: '13/9/2003', height: 57),
                SizedBox(height: 14,),
                ProfileMenuWidget(title:"Country",icon:Icons.flag,
                  onpress: (){}, subtitle: 'aa', height: 57),
                SizedBox(height: 14,),
                ProfileMenuWidget(title:"Interesrts",icon:Icons.psychology,
                  onpress: (){}, subtitle: '/////', height: 57),
                SizedBox(height: 14,),



              ],
            ),

          ),]

      ),
    );
  }
  fetchUserProfile() async {
    await http.get(Uri.parse(
        'http://192.168.118.128:8000/api/profile'),
        headers: {

          'Authorization':'Bearer $token'
        }
    ).then((value) {

      prof =jsonDecode(value.body);
      print(prof['data']);
      if(value.statusCode==200||value.statusCode==201){
        Get.snackbar(
            ' success',prof['data']['name'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white);


      }else {
        print('error');
      }
    });
  }
}


