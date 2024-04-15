import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'update_profile_screen.dart';
import 'widgets/profile_menu.dart';

class Profile extends StatelessWidget {
  static String id = "Profile";
  const Profile({super.key});

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
          // decoration: BoxDecoration( gradient: LinearGradient(
          //     colors: [
          //       Colors.white,
          //       Color( 0xFFE6E8E7)
          //     ],
          //     begin: Alignment.bottomLeft,
          //     end: Alignment.topRight
          // ),),

          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: 120,
                      height: 120,
                      child:ClipRRect(borderRadius: BorderRadius.circular(100),child: Image (image:AssetImage('assets/images/profile.jpg')))
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
              ProfileMenuWidget(title:"Name ",icon:Icons.person,onpress: (){}, subtitle: 'ElineFaramnd',),
              SizedBox(height: 14,),
              ProfileMenuWidget(title:"Email",icon:Icons.email,onpress: (){}, subtitle: 'Eline@gmail.com',),
              SizedBox(height: 14,),
              ProfileMenuWidget(title:"Phone",icon:Icons.phone,
                onpress: (){}, subtitle: '099999999',),
              SizedBox(height: 14,),
              ProfileMenuWidget(title:"Gender",icon:Icons.wc,
               onpress: (){}, subtitle: 'female',),
              SizedBox(height: 14,),
              ProfileMenuWidget(title:"Birth_Date",icon:Icons.celebration,
                onpress: (){}, subtitle: '13/9/2003',),
              SizedBox(height: 14,),
              ProfileMenuWidget(title:"Country",icon:Icons.flag,
                onpress: (){}, subtitle: 'sy',),
              SizedBox(height: 14,),
              ProfileMenuWidget(title:"Interesrts",icon:Icons.psychology,
                onpress: (){}, subtitle: '/////',),
              SizedBox(height: 14,),



            ],
          ),

        ),]

      ),
    );
  }
}


