import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart'; // تأكد من تحديث المسار الصحيح
import 'package:http/http.dart' as http;
import 'package:learningapp/data/http.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _textController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
//eli
  Future<void> _createPost() async {
    if (_textController.text.isEmpty || _imageFile == null) {
      Get.snackbar('Error', 'Please provide both text and image.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseurl'+'blog/createpost'), // تأكد من صحة المسار
      );

      // إضافة النص
      request.fields['text'] = _textController.text;

      // إضافة الصورة
      request.files.add(
        await http.MultipartFile.fromPath(
          'image_url', // اسم الحقل الذي يتوقعه الخادم
          _imageFile!.path,
        ),
      );

      // إذا كان الخادم يتطلب توكن مصادقة، أضف هنا:
      request.headers['Authorization'] = 'Bearer BbMh5L2lg00pVhrIOUiMm5CUCvqOpSAtlemt1XQG706f02ee';

      var response = await request.send();

      // طبع الاستجابة للتحقق
      final responseBody = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      // التعامل مع الاستجابة
      if (response.statusCode == 200 || response.statusCode == 201) {
        var res = jsonDecode(responseBody);
        Get.snackbar(
          'Success', res['status'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Kcolor,
          colorText: Colors.white,
        );
        Navigator.pop(context);
      } else {
        var res = jsonDecode(responseBody);
        Get.snackbar(
          'Error', res['status'].toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        print(res['status']);
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
        title: Text('Create Post'),
        backgroundColor: Kcolor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Picker
            _imageFile == null
                ? GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 140,
                width: double.infinity,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey[600]),
                ),
              ),
            )
                : Container(
              height: 140,
              width: double.infinity,
              child: Image.file(
                _imageFile!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Text Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _textController,
                maxLines: null, // Allows the text field to grow vertically as needed
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  hintText: 'Enter post text...',
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            // Submit Button
            ElevatedButton(
              onPressed: _createPost,
              child: Text('Create Post'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Kcolor, // Use your color constant
                minimumSize: Size(double.infinity, 45), // Button width
              ),
            ),
          ],
        ),
      ),
    );
  }
}
