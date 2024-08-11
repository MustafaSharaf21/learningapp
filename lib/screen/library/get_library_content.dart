import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import '../../data/http.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<dynamic> library = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
        backgroundColor: Kcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عدد الأعمدة في العرض
            mainAxisSpacing: 8, // المسافة بين الصفوف
            crossAxisSpacing: 8, // المسافة بين الأعمدة
            childAspectRatio: 0.55, // نسبة الطول إلى العرض
          ),
          itemCount: library.length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), // جعل الزوايا دائرية
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصورة
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/creatTest3.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                // العنوان
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    library[index]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // الأزرار
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // زر الشراء
                      ElevatedButton.icon(
                        onPressed: () {
                          buy(library[index]['id']);
                          print(library[index]['id'].toString());
                        },
                        icon: Icon(Icons.shopping_cart, size: 17),
                        label: Text('Replace'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Kcolor,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      // النقاط
                      GestureDetector(
                        onTap: () {
                          // إضافة الوظيفة المطلوبة عند الضغط على الأيقونة
                        },
                        child: Row(
                          children: [
                            Text(
                              library[index]['xp'].toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            Text('xp'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchLibrary() async {
    try {
      final response = await HttpHelper.gettData(url: 'sidebar/getlibrarycontent');
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          library = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> buy(int bookId) async {
    await HttpHelper.postData(url: 'sidebar/librarypaying/$bookId').then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      if (value.statusCode == 200 || value.statusCode == 201) {
        Get.snackbar(
          'Success',
          res['data']['original']['message'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          res['status'].toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    });
  }
}
