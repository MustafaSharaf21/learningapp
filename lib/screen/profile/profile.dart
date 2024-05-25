import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learningapp/screen/profile/update_profile_screen.dart';
import 'package:learningapp/screen/profile/widgets/profile_menu.dart';

import '../../data/http.dart';

class profilepage extends StatefulWidget {
  static String id = "profilepage";

  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<profilepage> {
  Map<String, dynamic> prof = {};

  @override
  void initState() {
    fetchUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: prof.isNotEmpty
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        prof['data']['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
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
                      child: const Icon(Icons.edit_outlined, size: 15),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                prof['data']['name'],
                style: TextStyle(fontFamily: 'Pacifico'),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 150,
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEEF5F2).withOpacity(.9),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen(),
                      ),
                    ),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Color(0xFF399679)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            Center(child: Column(children: [
              ProfileMenuWidget(
                title: "Name",
                icon: Icons.person,
                onpress: () {},
                subtitle: prof['data']['name'],
                height: 57,
              ),
              const SizedBox(height: 14),
              ProfileMenuWidget(
                title: "Email",
                icon: Icons.email,
                onpress: () {},
                subtitle: prof['data']['email'],
                height: 57,
              ),
              const SizedBox(height: 14),
              ProfileMenuWidget(
                title: "Phone",
                icon: Icons.phone,
                onpress: () {},
                subtitle: prof['data']['mobile_number'],
                height: 57,
              ),
              const SizedBox(height: 14),
              ProfileMenuWidget(
                title: "Gender",
                icon: Icons.wc,
                onpress: () {},
                subtitle: prof['data']['gender'],
                height: 57,
              ),
              const SizedBox(height: 14),
              ProfileMenuWidget(
                title: "Birth Date",
                icon: Icons.celebration,
                onpress: () {},
                subtitle: prof['data']['birth_date'],
                height: 57,
              ),
              const SizedBox(height: 14),
              ProfileMenuWidget(
                title: "Country",
                icon: Icons.flag,
                onpress: () {},
                subtitle: prof['data']['country']['name'],
                height: 57,
              ),
              const SizedBox(height: 14),
              ProfileMenuWidget(
                title: "Interests",
                icon: Icons.psychology,
                onpress: () {},
                subtitle: prof['data']['interests'].values.join(', '),
                height: 70,
              ),
              const SizedBox(height: 14),
            ],),)
            ],
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  fetchUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.63:8000/api/profile'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          prof = jsonDecode(response.body);
        });
        Get.snackbar(
          'Success',
          prof['data']['name'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      } else {
        print('Error');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
