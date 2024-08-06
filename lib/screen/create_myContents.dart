import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/http.dart';
import '../../core/widgets/buildInputDecoration.dart';
import '../data/models/Getx_Controller.dart';
import 'my_contants.dart';


class createMyContents extends StatefulWidget {

  createMyContents( {super.key});

  @override
  State<createMyContents> createState() => _createMyContentsState();
}

class _createMyContentsState extends State<createMyContents> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController ContentNameCtrl = TextEditingController();
  TextEditingController ContentUrlCtrl = TextEditingController();
  TextEditingController idd = TextEditingController();
  TextEditingController courseIdCtrl = TextEditingController(); // New controller for course_id
  final Map<String,int> roles = {'video':1, 'Pdf':2}; // Updated to string values
  String? selectedRole;
  int? selectedRoleId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final courseId = Get.find<UserRoleController>().courseId.value;
    final iconColor = Theme.of(context).iconTheme.color;
    return Scaffold(
      backgroundColor: Kcolor,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Kcolor,
                ),
              ),
              Expanded(
                  child: Container(
                    color: Colors.white,
                  ))
            ],
          ),
          Column(
            children: [
              Container(
                height: Get.height * .15,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Kcolor,
                      Colors.greenAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Create myContents',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Color(0xFFB2CCC8),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.school,
                              size: 25,
                              color: Kcolor,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Teacher',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'You can create Contents here',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 155, 155, 155),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  controller: ContentNameCtrl,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name";
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                    context,
                                    Icons.library_books_sharp,
                                    " Name",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  controller: ContentUrlCtrl,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Url";
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                    context,
                                    Icons.link,
                                    " Url",
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 5),
                                      child: Icon(Icons.person, color: iconColor),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 5),
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.circular(30),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: iconColor,
                                          size: 30,
                                        ),
                                        dropdownColor: Colors.white,
                                        hint: const Text(
                                          "Choose video or pdf",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF464241),
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                        items: roles.entries.map((entry) {
                                          return DropdownMenuItem<String>(
                                            value: entry.key,
                                            child: Text(
                                              entry.key,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedRole = newValue;
                                            selectedRoleId = roles[newValue];
                                            idd.text = selectedRoleId.toString();
                                            print('Selected role: $selectedRole, ID: $selectedRoleId');
                                          });
                                        },
                                        value: selectedRole,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              createMycontent(courseId);
                            }
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Kcolor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text(
                              'Create Content',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  createMycontent(int courseId) async {

    await HttpHelper.postData(url: 'content/create', body: {
      'name': ContentNameCtrl.text,
      'url': ContentUrlCtrl.text,
      'type_id': idd.text,
      'course_id':courseId.toString(),
    }).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        Get.to(myContents());
      } else {
        print(res);
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
