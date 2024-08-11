import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants.dart';
import '../../data/http.dart';
import '../PdfViewerPage.dart';

class MyLibrary extends StatefulWidget {
  const MyLibrary({super.key});

  @override
  State<MyLibrary> createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  List<dynamic> my_library = [];
  bool isLoading = true;
  bool nobook = false;
  // خريطة لتتبع حالة عرض الوصف لكل عنصر
  Map<int, bool> showDescription = {};

  @override
  void initState() {
    super.initState();
    fetchMyLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY Library'),
        backgroundColor: Kcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : nobook
            ? Center(
          child: Text(
            'There are not items yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        )
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.55,
          ),
          itemCount: my_library.length,
          itemBuilder: (context, index) {
            final item = my_library[index];
            final isShowingDescription = showDescription[index] ?? false;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentViewer(
                      documentUrl: item['url'],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الصورة
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                               // image: NetworkImage(item['image']),

                                image: AssetImage('assets/images/creatTest3.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showDescription[index] = !isShowingDescription;
                                });
                              },
                              child: Icon(
                                Icons.warning,
                                color: Kcolor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // العنوان
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['title'] ?? 'No Title',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // عرض/إخفاء الوصف
                    if (isShowingDescription)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            item['description'] ?? 'No description available',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                        ),
                      ),
                    // الأزرار
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // زر الاسترداد
                          ElevatedButton.icon(
                            onPressed: () {
                              refaunding(item['id']);
                            },
                            icon: Icon(Icons.restore, size: 17),
                            label: Text('Refaund'),
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
                              // يمكن إضافة وظيفة هنا إذا لزم الأمر
                            },
                            child: Row(
                              children: [
                                Text(
                                  item['xp'].toString(),
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
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchMyLibrary() async {
    try {
      final response = await HttpHelper.gettData(url: 'sidebar/getmylibrary');
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          my_library = data;
          isLoading = false;
          nobook = my_library.isEmpty;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> refaunding(int bookId) async {
    await HttpHelper.postData(url: 'sidebar/libraryrefaunding/$bookId').then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      if (value.statusCode == 200 || value.statusCode == 201) {
        setState(() {});
        Get.snackbar(
          'Success',
          res['message'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          res['error'].toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    });
  }
}
