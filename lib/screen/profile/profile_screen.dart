import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/http.dart';
import '../../data/models/profile_model.dart';
import 'update_profile_screen.dart';
import 'widgets/profile_menu.dart';

class Profile extends StatelessWidget {
  static String id = "Profile";

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: () {},),
        ),
        body: FutureBuilder<UserProfile>(
            future: fetchUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error:${snapshot.error}');
              } else {
                final profile = snapshot.data!;
                return ListView(
                    children: [
                      Container(padding: const EdgeInsets.all(8),
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
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        child: snapshot.data!.image != null
                                            ? Image.network(
                                            snapshot.data!.image!)
                                            :
                                        Image.asset('assets/images/profile.jpg')
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
                                    child: const Icon(
                                      Icons.edit_outlined, size: 15,),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Text("Eline Faramnd",
                              style: TextStyle(fontFamily: 'Pacifico'),),
                            SizedBox(height: 10,),
                            SizedBox(width: 150, child: Container(

                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(
                                            0xFFEEF5F2).withOpacity(.9)),
                                    onPressed: () =>
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateProfileScreen(),)),
                                    child: const Text("Edit Profile",
                                      style: TextStyle(
                                          color: Color(0xFF399679)),)))),
                            const SizedBox(height: 2.5,),
                            const Divider(color: Color(0xC7EAEAEA),),
                            const SizedBox(height: 5,),
                            ProfileMenuWidget(title: "Name ",
                              icon: Icons.person,
                              onpress: () {},
                              subtitle: profile.name,),
                            SizedBox(height: 14,),
                            ProfileMenuWidget(title: "Email",
                              icon: Icons.email,
                              onpress: () {},
                              subtitle: profile.email,),
                            SizedBox(height: 14,),
                            ProfileMenuWidget(title: "Phone", icon: Icons.phone,
                              onpress: () {}, subtitle: profile.mobileNumber,),
                            SizedBox(height: 14,),
                            ProfileMenuWidget(title: "Gender", icon: Icons.wc,
                              onpress: () {}, subtitle: profile.gender,),
                            SizedBox(height: 14,),
                            ProfileMenuWidget(
                              title: "Birth_Date", icon: Icons.celebration,
                              onpress: () {}, subtitle: '${profile.birth_date
                                .toLocal()}'.split('')[0],),
                            SizedBox(height: 14,),
                            ProfileMenuWidget(
                              title: "Country", icon: Icons.flag,
                              onpress: () {}, subtitle: profile.country,),
                            SizedBox(height: 14,),
                            ProfileMenuWidget(
                                title: "Interesrts", icon: Icons.psychology,
                                onpress: () {}, subtitle: '${
                                (snapshot.data!.interests.join(','), )
                            }'),
                            SizedBox(height: 14,),


                          ],
                        ),

                      ),
                    ]

                );
              }
            }
        )

    );
  }

  fetchUserProfile() async {
    await http.get(Uri.parse(
        'http://192.168.230.164:8000/api/logout2'),
        headers: {

          'Authorization': 'Bearer $token'
        }
    ).then((value) {
      Map<String, dynamic>res = jsonDecode(value.body);
      print(res['message']);
      if (value.statusCode == 200 || value.statusCode == 201) {
        Get.snackbar(
            'signed out', res['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white);
      } else {
        print('error');
      }
    });
  }
}

