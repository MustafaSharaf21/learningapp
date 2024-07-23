import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/http.dart';
import 'package:learningapp/generated/l10n.dart';
import '../../core/widgets/buildInputDecoration.dart';
import 'home_screen.dart';
import 'package:intl/intl.dart';




class CreateLive extends StatefulWidget {
  const CreateLive({super.key});
  static String id = "CreateLive";

  @override
  State<CreateLive> createState() => _CreateLiveState();
}

class _CreateLiveState extends State<CreateLive> {

  String? selectedSpe;
  List<DropdownMenuItem<int>> specializationItems = [];
  Map<String, dynamic> specializations = {};
  TextEditingController speIdd = TextEditingController();
  int? selectedSpecializeId;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameTeacher = TextEditingController();
  TextEditingController titleLive = TextEditingController();
  TextEditingController timeLive = TextEditingController();
  TextEditingController dateLive = TextEditingController();
  TextEditingController linkLive = TextEditingController();

  @override
  void initState() {
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
                padding:const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration:const BoxDecoration(
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
                      child:const Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      S.of(context).Create_Live,
                      style: const TextStyle(
                        fontSize: 20,
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
                  const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                  decoration:const BoxDecoration(
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
                            const Icon(
                              Icons.school,
                              size: 25,
                              color: Kcolor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).Welcome_Teacher,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  S.of(context).You_can_create_Live_here,
                                  style: const TextStyle(
                                    color:  Color.fromARGB(
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
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  cursorColor: Kcolor,
                                  controller: titleLive,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S.of(context).Enter_a_Time;
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.title, S.of(context).Title),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  cursorColor: Kcolor,
                                  controller: timeLive,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S.of(context).Enter_a_Time;
                                    }
                                    final timeRegExp = RegExp(r'^[0-2][0-9]:[0-5][0-9]$');
                                    if (!timeRegExp.hasMatch(value)) {
                                      return S.of(context).Invalid_Time_Format;
                                    }
                                    int hours = int.parse(value.split(":")[0]);
                                    if (hours > 23) {
                                      return S.of(context).Invalid_Hours;
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.access_time,S.of(context).Time),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  cursorColor: Kcolor,
                                  controller: dateLive,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S.of(context).Enter_Date;
                                    }try {
                                      DateTime enteredDate = DateFormat('yyyy-MM-dd').parse(value);
                                      if (enteredDate.isBefore(DateTime.now())) {
                                        return S.of(context).Cannot_enter_a_past_date;
                                      }
                                    } catch (e) {
                                      return S.of(context).Enter_the_date_correctly_yyyy_MM_dd;
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.date_range, S.of(context).Date),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  cursorColor: Kcolor,
                                  controller: linkLive,
                                  keyboardType: TextInputType.url,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S.of(context).Enter_a_link;
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.link, S.of(context).Add_link),
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
                                              vertical: 5),
                                          child: DropdownButton<int>(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            underline: const Divider(
                                                thickness: 0, height: 0),
                                            icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xFF464241)),
                                            dropdownColor:const Color(0xFFB2CCC8),
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
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              createLive();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return HomePage();
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
                              S.of(context).Create_Live,
                              style: const TextStyle(
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

  createLive() async {

    await HttpHelper.postData(url: 'live/createlive', body: {
      'title':titleLive.text,
      'time_start':timeLive.text,
      'date_start':dateLive.text,
      'code': linkLive.text,
      'specialization_id': speIdd.text,

    }).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res['data']['token'];
        GetStorage _box = GetStorage();
        _box.write('token', token);
        Get.snackbar(
            ' ', res['status'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white
        );
        print(res);
        print(token);
        Get.to(HomePage());
      } else {
        print(res);
        Get.snackbar(
            'Error', res['status'].toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white

        );
      }
    });

  }




  }








