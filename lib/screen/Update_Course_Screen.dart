
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../data/http.dart';
import '../data/models/Getx_Controller.dart';
import '../generated/l10n.dart';
import 'Content_management.dart';

class UpdateCoursePage extends StatefulWidget {
  final dynamic course;


   UpdateCoursePage({Key? key, required this.course}) : super(key: key);

  @override
  _UpdateCoursePageState createState() => _UpdateCoursePageState();
}

class _UpdateCoursePageState extends State<UpdateCoursePage> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _specializationIdController = TextEditingController();
  final TextEditingController _countryIdController = TextEditingController();
  TextEditingController SpeIdd = TextEditingController();
  TextEditingController countryIdd = TextEditingController();

  String? selectedSpe;
  List<DropdownMenuItem<int>> specializationItems = [];
  int? selectedSpecializeId;
  Map<String, dynamic> specializations = {};

  String? selectedCountry;
  List<DropdownMenuItem<int>> countryItems = [];
  int? selectedCountryId;
  int? countryId;
  Map<String, dynamic> countries = {};


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.course['name'];
    _descriptionController.text = widget.course['description'];
    //_specializationIdController.text = widget.course['specialization_id'];
   // _countryIdController.text = widget.course['country_id'];
    fetchSpesialization();
    fetchCountry();
  }


  @override
  Widget build(BuildContext context) {
    //final userId = Get.find<UserRoleController>().userId.value;
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
                      'Update course',
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
                                  'You can Update Course here',
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
                                  controller: _descriptionController,
                                  maxLines: 3,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'description is required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container(
                                  width: double.infinity,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding:
                                        EdgeInsets.only(left: 10, top: 5),
                                        child: Icon(Icons.school_sharp,
                                            color: Color(0xFF413F3F)),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5), // تعديل الحشوات
                                          child: DropdownButton<int>(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            underline: const Divider(
                                                thickness: 0, height: 0),
                                            icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xFF464241)),
                                            dropdownColor: const Color(
                                                0xFFB2CCC8),
                                            hint: Text(
                                              selectedSpe ??
                                                  S
                                                      .of(context)
                                                      .specialization,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF464241),
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            items: specializationItems,
                                            onChanged: (int? item) {
                                              setState(() {
                                                GetStorage().write(
                                                    'selectedCountryId', item);
                                                selectedSpe =
                                                specializations['data']
                                                    .firstWhere((c) =>
                                                c['id'] ==
                                                    item)['name'];
                                                selectedSpecializeId = item;
                                                SpeIdd.text = selectedSpecializeId
                                                    .toString();
                                              });
                                              print(
                                                  'Selected Specialize ID: $item');
                                              print(
                                                  'Specialize id to back:$selectedSpecializeId');
                                              //sendSelectedCountryToBackend(item);
                                            },
                                            value: selectedSpecializeId,
                                            isExpanded: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container(
                                  width: double.infinity,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding:
                                        EdgeInsets.only(left: 10, top: 5),
                                        child: Icon(Icons.location_city,
                                            color: Color(0xFF413F3F)),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5), // تعديل الحشوات
                                          child: DropdownButton<int>(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            underline: const Divider(
                                                thickness: 0, height: 0),
                                            icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xFF464241)),
                                            dropdownColor: const Color(
                                                0xFFB2CCC8),
                                            hint: Text(
                                              selectedCountry ??
                                                  S
                                                      .of(context)
                                                      .Country,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF464241),
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            items: countryItems,
                                            onChanged: (int? item) {
                                              setState(() {
                                                GetStorage().write(
                                                    'selectedCountryId', item);
                                                selectedCountry =
                                                countries['data']
                                                    .firstWhere((c) =>
                                                c['id'] ==
                                                    item)['name'];
                                                selectedCountryId = item;
                                                countryIdd.text =
                                                    selectedCountryId
                                                        .toString();
                                              });
                                              print(
                                                  'Selected country ID: $item');
                                              print(
                                                  'country id to back:$selectedCountryId');
                                              //sendSelectedCountryToBackend(item);
                                            },
                                            value: selectedCountryId,
                                            isExpanded: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                              updateCourse();
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
                              'Update course',
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

  void fetchSpesialization() {
    HttpHelper.gettData(url: 'getSpecializations').then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        setState(() {
          specializations = jsonDecode(value.body);
          specializationItems = (specializations['data'] as List)
              .map((Specialize) =>
              DropdownMenuItem<int>(
                value: Specialize['id'],
                child: Text(Specialize['name']),
              ))
              .toList();
        });
      } else {
        print('Error fetching countries');
      }
    });
  }

  void fetchCountry() {
    HttpHelper.gettData(url: 'getCountries').then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        setState(() {
          countries = jsonDecode(value.body);
          countryItems = (countries['data'] as List)
              .map((country) =>
              DropdownMenuItem<int>(
                value: country['id'],
                child: Text(country['name']),
              ))
              .toList();
        });
      } else {
        print('Error fetching countries');
      }
    });
  }


  Future<void> updateCourse() async {
    //print("widget.course['id']---------------${widget.course['id']}");
    try {
      final response = await http.post(
        Uri.parse('$baseurl' + 'course/update/${widget.course['id']}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'description': _descriptionController.text,
          'specialization_id': SpeIdd.text.toString(),
          'country_id': countryIdd.text.toString(),
          'status': "pending",
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


/*'specialization_id': SpeIdd.text,
          'country_id': countryIdd.text,*/

/*

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../data/http.dart';

class UpdateCoursePage extends StatefulWidget {
  final Map<String, dynamic> course;


  UpdateCoursePage({required this.course});

  @override
  _UpdateCoursePageState createState() => _UpdateCoursePageState();
}

class _UpdateCoursePageState extends State<UpdateCoursePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _specializationIdController;
  late TextEditingController _countryIdController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.course['name']);
    _descriptionController = TextEditingController(text: widget.course['description']);
    _specializationIdController = TextEditingController(text: widget.course['specialization_id']);
    _countryIdController = TextEditingController(text: widget.course['country_id']);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _specializationIdController,
                decoration: InputDecoration(labelText: 'Specialization ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter specialization ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countryIdController,
                decoration: InputDecoration(labelText: 'Country ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter country ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateCourse,
                child: Text('Update Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> updateCourse() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('$baseurl' + 'course/update/${widget.course['id']}'),
          headers: {'Authorization': 'Bearer $token'},
          body: {
            'name': _nameController.text,
            'description': _descriptionController.text,
            'specialization_id': _specializationIdController.text,
            'country_id': _countryIdController.text,
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseData = jsonDecode(response.body);
          if (responseData['status'] == 'Success') {
            Navigator.pop(context, true);
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
}
*/
