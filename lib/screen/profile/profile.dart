import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learningapp/screen/profile/update_profile_screen.dart';
import 'package:learningapp/screen/profile/widgets/profile_menu.dart';

import '../../data/http.dart';

class profilepage extends StatefulWidget {
  static String id = "profilepage";
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  Map <String,dynamic> prof={};
  @override
  void initState() {
    fetchUserProfile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Profile'),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){},),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Container(
                height: 1000,
                child: prof.isNotEmpty?ListView.builder(
                    itemCount: prof.length,
                    itemBuilder: (context, ind) =>
                    Container(padding: const EdgeInsets.all(8),
                
                
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Text(prof['data']['name']),
                              SizedBox(
                                  width: 120,
                                  height: 120,
                                  child:ClipRRect(borderRadius: BorderRadius.circular(100),
                                      child: Image.network('${prof['data']['image']}')
                
                                    //   Image (image:AssetImage('assets/images/profile.jpg'))
                                  )
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
                          Text("Eline Faramnd",style: TextStyle(fontFamily: 'Pacifico'),),
                          SizedBox(height: 10,),
                          SizedBox(width:150,child:  Container(
                
                              child: ElevatedButton( style:ElevatedButton.styleFrom(backgroundColor: Color(
                                  0xFFEEF5F2).withOpacity(.9)),onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(),)), child: const Text("Edit Profile",style: TextStyle(color: Color(0xFF399679)),) ))),
                          const SizedBox(height: 2.5,),
                          const Divider(color: Color(0xC7EAEAEA),),
                          const SizedBox(height: 5,),
                          ProfileMenuWidget(title:"Name ",icon:Icons.person,onpress: (){}, subtitle:prof['data']['name'],),
                          SizedBox(height: 14,),
                          ProfileMenuWidget(title:"Email",icon:Icons.email,onpress: (){}, subtitle:prof['data']['email'],),
                          SizedBox(height: 14,),
                          ProfileMenuWidget(title:"Phone",icon:Icons.phone,
                            onpress: (){}, subtitle: prof['data']['mobile_number'],),
                          SizedBox(height: 14,),
                          ProfileMenuWidget(title:"Gender",icon:Icons.wc,
                            onpress: (){}, subtitle: prof['data']['gender'],),
                          SizedBox(height: 14,),
                          // ProfileMenuWidget(title:"Birth_Date",icon:Icons.celebration,
                          //   onpress: (){}, subtitle: '${profile.birth_date.toLocal()}'.split('')[0],),
                          // SizedBox(height: 14,),
                          // ProfileMenuWidget(title:"Country",icon:Icons.flag,
                          //   onpress: (){}, subtitle: profile.country,),
                          // SizedBox(height: 14,),
                          // ProfileMenuWidget(title:"Interesrts",icon:Icons.psychology,
                          //     onpress: (){}, subtitle: '${
                          //         (snapshot.data!.interests.join(','),)
                          //     }'),
                          // SizedBox(height: 14,),
                          //
                          //
                
                        ],
                      ),
                
                    )):Center(child: CircularProgressIndicator(),),
              )
            ),
          ],
        ),
      ),




    );
  }
  fetchUserProfile() async {
    await http.get(Uri.parse(
        'http://192.168.43.63:8000/api/profile'),
        headers: {

          'Authorization':'Bearer $token'
        }
    ).then((value) {

     prof =jsonDecode(value.body);
      print(prof['status']);
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
