import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../data/http.dart';
import 'content_category.dart';

class Category extends StatefulWidget {
  static String id = "Category";
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<dynamic> category = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GestureDetector(
        child: Container(
          padding: EdgeInsets.only(top: 8,right: 9,left: 9),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 30,
              crossAxisCount: 3,
            ),
            itemCount: category.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoursesPage(
                        categoryId: category[i]["id"],
                        categoryName: category[i]["name"],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Kcolor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 180,
                  margin: EdgeInsets.only(left: 0, right: 0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Center(
                        child: Text(
                          category[i]["name"],
                          style: TextStyle(
                            color: Colors.black, // اللون الأسود للنص
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> fetchCategory() async {
    try {
      final response = await HttpHelper.gettData(url: 'getSpecializations');
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          category = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
/////