import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learningapp/screen/home_screen.dart';
import 'package:learningapp/screen/login_screen.dart';
import 'package:learningapp/screen/profile/profile_screen.dart';

import '../../data/http.dart';
import 'profile.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? _image;
  final _picker = ImagePicker();
  TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 7.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.camera);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/camera.jpg', width: 40, height: 40),
                      SizedBox(height: 5),
                      Text('Camera'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.gallery);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/gallery.jpg', width: 40, height: 40),
                      SizedBox(height: 5),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> editProfile() async {
    try {
      var fields = {
        'mobile_number': phone.text,
      };

      var response;
      if (_image != null) {
        response = await HttpHelper.uploadProfile(
          url: 'profile',
          fields: fields,
          file: _image!,
        );
      } else {
        response = await HttpHelper.postData(
          url: 'profile',
          body: fields,
        );
      }

      var res = jsonDecode(response.body);
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        token = res['data']['token'];
        GetStorage _box = GetStorage();
        _box.write('token', token);

        Get.snackbar(
          ' ', res['data']['message'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        Get.to(() => HomePage());
      } else {
        Get.snackbar(
          'Error', res['message'].toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error', 'Something went wrong. Please try again.',
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null ? Icon(Icons.person, size: 55) : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      showImagePickerOption(context);
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.camera_alt, size: 20, color: Colors.grey.shade700),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 110),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  editProfile();
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
