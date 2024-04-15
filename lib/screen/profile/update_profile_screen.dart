import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:learning_application/screens/login_screen.dart';

class UpdateProfileScreen extends StatefulWidget {

   UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
   //late File imageFile;
  // _showOption (BuildContext context){
  //   return showDialog(context: context, builder: (context)=>
  //   AlertDialog(
  //     title: Text("Make a choice"),
  //     content: SingleChildScrollView(child: Column(
  //       children: [
  //         ListTile(
  //           leading: Icon(Icons.image),
  //           title: Text("Gallery"),
  //           onTap: ()=>_imageFromGallery(context),
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.camera_alt_outlined),
  //           title: Text("Camera"),
  //           onTap: ()=>_imageFromCamera(context),
  //         )
  //       ],
  //     ),),
  //   ));
  // }
    // Future _imageFromGallery(BuildContext context) async{
    // //var image=ImagePicker.
    // }
   // Future _imageFromCamera(BuildContext context) async{}
  bool pass = true;
   GlobalKey<FormState> formstate = GlobalKey();

   TextEditingController phone_num=TextEditingController();

   TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(backgroundColor: Colors.white,centerTitle: true,
       leading: IconButton(onPressed: (Get.back),icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 20,),),
       title: Text("Edit Profile",style: TextStyle(color: Colors.black),
     ),),
      body: SingleChildScrollView
        (
        child: Container(height:700,
    decoration:const  BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Colors.white,
      Color(0xFFE6E8E7)],//Color(0xFFBCF3E2)
    begin: Alignment.bottomLeft,
    end: Alignment.topRight
    ),
    ),
          padding: EdgeInsets.only(left: 35,right: 35,bottom: 35),
          child: Column(
            children: [
              SizedBox(height: 50,),
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
                      child:  IconButton(icon:Icon(Icons.camera_alt_outlined,size: 15),onPressed: (){}),
                    ),
                  )
                ],
              ),
              const SizedBox(height:80),
              Form(
                  key: formstate,
                  child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      isDense:true,border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                    label: Text("Name"),prefixIcon: Icon(Icons.person,size: 20,)
                  ),
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  decoration: InputDecoration(isDense:true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      label: Text("Email"),prefixIcon: Icon(Icons.email_outlined,size: 20,)
                  ),
                ),

                SizedBox(height: 60,),
                SizedBox(child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF399679)),
                        onPressed: (){}, child: const Text("Save",style: TextStyle(color: Colors.white),) ,),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: (){}, child: const Text("cancel",style: TextStyle(color: Color(0xFF399679)),) ),
                  ],
                )
                ),
              ],))
            ],
        ),
      )
    ));
  }
}
