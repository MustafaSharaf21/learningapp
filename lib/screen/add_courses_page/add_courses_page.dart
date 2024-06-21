import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/http.dart';
import 'package:learningapp/main.dart';

import '../../core/widgets/buildInputDecoration.dart';
import '../../data/models/course/cources.dart';
import '../../generated/l10n.dart';
import '../home_screen.dart';

class AddCoursesPage extends StatefulWidget {
  AddCoursesPage({super.key});

  @override
  State<AddCoursesPage> createState() => _AddCoursesPageState();
}

class _AddCoursesPageState extends State<AddCoursesPage> {
  // specialization variables
  String? selectedSpe;

  List<DropdownMenuItem<int>> specializationItems = [];
  Map<String, dynamic> specializations = {};
  TextEditingController speIdd = TextEditingController();
  int? selectedSpecializeId;
  // country variables
  String? selectedCountry;
  List<DropdownMenuItem<int>> countryItems = [];
  int? selectedCountryId;
  int? countryId;
  Map<String, dynamic> countries = {};
  TextEditingController countryIdd = TextEditingController();
  // key
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // controllers
  TextEditingController courseNameCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  @override
  void initState() {
    fetchCountry();
    fetchSpesialization();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
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
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Add course',
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
                      EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
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
                        Row(
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
                                  'You can create Course here',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 155, 155, 155),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              InkWell(
                                onTap: () {
                                  showOption(context);
                                },
                                child: Container(
                                  height: 150,
                                  // width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.grey[700]!,
                                      )),
                                  child: image != null
                                      ? Image.file(
                                          image!,
                                          fit: BoxFit.fill,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 24,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Add Photo',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                fontFamily: 'Cairo',
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  controller: courseNameCtrl,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S.of(context).Enter_a_name;
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.person, S.of(context).Full_Name),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  controller: descriptionCtrl,
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
                                            dropdownColor: Color(0xFFB2CCC8),
                                            hint: Text(
                                              selectedCountry ??
                                                  S.of(context).Country,
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
                                            dropdownColor: Color(0xFFB2CCC8),
                                            hint: Text(
                                              selectedSpe ??
                                                  S.of(context).specialization,
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
                                                speIdd.text =
                                                    selectedSpecializeId
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              addCourseConnect();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MyHomePage();
                              }));
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
                            child: Text(
                              'Create course',
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
              .map((Specialize) => DropdownMenuItem<int>(
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
              .map((country) => DropdownMenuItem<int>(
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

  void addCourseConnect() async {
    if (image == null)
      return;
    else {
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseurl' + 'course/create'));
      request.fields.addAll({
        'name': courseNameCtrl.text,
        'specialization_id': speIdd.text,
        'description': descriptionCtrl.text,
        'status': 'accepted',
        'country_id': countryIdd.text,
      });
      request.files
          .add(await http.MultipartFile.fromPath('image', image!.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  File? image;
  final _pickedFile = ImagePicker();
  showOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("make a choice"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text("Gallery"),
                      onTap: () => _imageFromGallery(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt_outlined),
                      title: const Text("Camera"),
                      onTap: () => _imageFromCamera(context),
                    ),
                  ],
                ),
              ),
            ));
  }

  Future _imageFromGallery(BuildContext context) async {
    var pickedImage = await _pickedFile.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {}
    Navigator.pop(context);
  }

  Future _imageFromCamera(BuildContext context) async {
    var pickedImage = await _pickedFile.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {}
    Navigator.pop(context);
  }
}
