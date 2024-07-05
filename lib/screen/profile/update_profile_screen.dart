import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../data/http.dart';

class UpdateProfileScreen extends StatefulWidget {
  static String id = "UpdateProfileScreen";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UpdateProfileScreen> {
  File? _image;
  final _picker = ImagePicker();
  TextEditingController phoneController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_image == null || phoneController.text.isEmpty) {
      // يمكنك إظهار رسالة خطأ هنا إذا كانت الصورة أو رقم الجوال غير موجود
      return;
    }

    // URL لواجهة برمجة التطبيقات الخاصة بك
    var uri = Uri.parse('http://192.168.118.128:8000/api/profile');
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer$token' // إضافة رأس التوثيق
      ..fields['mobile_number'] = phoneController.text // حقل رقم الجوال
      ..files.add(await http.MultipartFile.fromPath(
        'image', // اسم الحقل للصورة في الباك إند
        _image!.path,
      ));

    try {
      // إرسال الطلب وانتظار الاستجابة
      var response = await request.send();

      if (response.statusCode == 200) {
        // الطلب نجح
        print('Profile updated successfully.');
        // يمكنك هنا تحديث الواجهة أو الانتقال إلى صفحة أخرى
      } else {
        // حدث خطأ ما
        print('Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // التعامل مع الاستثناءات
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final ImageSource? source = await showDialog<ImageSource>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Select Image Source'),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () { Navigator.pop(context, ImageSource.camera); },
                          child: const Text('Camera'),
                        ),
                        SimpleDialogOption(
                          onPressed: () { Navigator.pop(context, ImageSource.gallery); },
                          child: const Text('Gallery'),
                        ),
                      ],
                    );
                  }
              );
              if (source != null) {
                await _pickImage(source);
              }
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? Icon(Icons.camera_alt, size: 55, color: Colors.grey.shade700)
                  : null,
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
            ),
            keyboardType: TextInputType.phone,
          ),
          ElevatedButton(
            onPressed: _saveProfile,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
