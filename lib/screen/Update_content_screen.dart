import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../data/http.dart';
import '../data/models/Getx_Controller.dart';
import 'Content_management.dart';

class UpdateContentPage extends StatefulWidget {
  final dynamic contents;


  UpdateContentPage({Key? key, required this.contents}) : super(key: key);

  @override
  _UpdateContentPageState createState() => _UpdateContentPageState();
}

class _UpdateContentPageState extends State< UpdateContentPage> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ContentUrlCtrl= TextEditingController();
  TextEditingController idd = TextEditingController();

  final Map<String,int> roles = {'video':1, 'Pdf':2}; // Updated to string values
  String? selectedRole;
  int? selectedRoleId;


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.contents['name'];
    _ContentUrlCtrl.text = widget.contents['url'];

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Kcolor,
                        Colors.greenAccent,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                    )),
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
                      'Update content',
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
                  padding:
                  const EdgeInsets.only(
                      top: 40, bottom: 20, left: 20, right: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      Color(0xFFB2CCC8),
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
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
                            SizedBox(
                              width: 10,
                            ),
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
                                  'You can Update content here',
                                  style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 155, 155, 155),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name";
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(context,
                                      Icons.library_books_sharp, " Name"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  controller:  _ContentUrlCtrl,
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



                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              updatecontent(courseId );
                              /*Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return const ContentManagement();
                                  }));*/

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
                              'Update content',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
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


  Future<void> updatecontent(int courseId ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseurl' + 'content/update/${widget.contents['id']}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name':_nameController.text,
          'url':_ContentUrlCtrl.text,
          'type_id': idd.text.toString(),
          'status': "pending",
          'course_id':courseId.toString()



        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);

        if (responseData['status'] == 'Success') {
          Get.snackbar(
            'Success',
            'The course is updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white,
          );
          Get.to(ContentManagement());
          //Navigator.pop(context, true);
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}

