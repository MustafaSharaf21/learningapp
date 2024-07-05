import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/http.dart';
import 'package:learningapp/screen/my_constants.dart';

import '../../core/widgets/buildInputDecoration.dart';
import '../../generated/l10n.dart';

class EditContentPage extends StatefulWidget {
  EditContentPage({super.key, required this.id});
  String id;
  @override
  State<EditContentPage> createState() => _EditContentPageState();
}

class _EditContentPageState extends State<EditContentPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController contentNameCtrl = TextEditingController();
  TextEditingController urlCtrl = TextEditingController();
  TextEditingController typeCtrl = TextEditingController();
  List<String> typeList = ['document', 'video'];
  String type = 'document';
  @override
  void initState() {
    getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Edite content',
        ),
        centerTitle: true,
      ),
      body: loadContentData == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
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
                                'You can Edit Content here',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 155, 155, 155),
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                controller: contentNameCtrl,
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
                                controller: urlCtrl,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Url is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Enter URL',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    )),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container(
                                  height: 56,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(width: 1.3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        type,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_drop_down,size: 28,),
                                        items: typeList
                                            .map(
                                                (e) {return DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            );}
                                        )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            type = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      loadingData == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {
                                  editContent();
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
                                  'Edit content',
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
    );
  }

  bool loadingData = false;
  bool loadContentData = true;
  String id = '';

  Map<String, dynamic> editData = {};
  Map<String, dynamic> getContentData = {};
  Future editContent() {
    setState(() {
      loadingData = true;
    });
    return HttpHelper.postData(url: 'content/update/$id', body: {
      'name': contentNameCtrl.text,
      'course_id': widget.id,
      'url': urlCtrl.text,
      'type': type,
    }).then((value) {
      print(value.body);
      if (value.statusCode == 200 || value.statusCode == 201) {
        setState(() {
          editData = jsonDecode(value.body);
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return myContents();
        }));
        Get.snackbar(
          'Edit content',
          'Edit content is done .. please refresh app th show it',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Kcolor,
          colorText: Colors.white,
        );
      } else {}
      setState(() {
        loadingData = false;
      });
    }).catchError((e) {
      setState(() {
        loadingData = false;
      });
      print(e.toString());
    });
  }

  Future getContent() {
    return HttpHelper.gettData(url: 'content/show/${widget.id}').then((value) {
      print(value.body);
      if (value.statusCode == 200 || value.statusCode == 201) {
        setState(() {
          getContentData = jsonDecode(value.body);
          id = (jsonDecode(value.body)['data'][0]['id']).toString();
          print(id);
        });
      } else {}
      setState(() {
        loadContentData = false;
      });
    }).catchError((e) {
      setState(() {
        loadContentData = false;
      });
      print(e.toString());
    });
  }
}
