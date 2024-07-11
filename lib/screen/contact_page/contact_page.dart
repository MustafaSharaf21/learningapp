import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import '../../core/widgets/buildInputDecoration.dart';
import '../../data/http.dart';
import '../../generated/l10n.dart';
import '../my_constants.dart';

class ContactPage extends StatefulWidget {
   ContactPage({super.key,required this.courseId});
   String courseId;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController contentNameCtrl=TextEditingController();
  TextEditingController urlCtrl=TextEditingController();
  TextEditingController typeCtrl=TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String> typeList = ['document', 'video'];
  String type = 'document';
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
                    const Text(
                      'Add Content',
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
                                  'You can add Content here',
                                  style: TextStyle(
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
                                          style:const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        DropdownButton(
                                          icon:const Icon(Icons.arrow_drop_down,size: 28,),
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

                        const SizedBox(
                          height: 30,
                        ),
                       loadingData==true?const Center(child: CircularProgressIndicator(),): InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              addContent();

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
                            child:const Text(
                              'Add content',
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
  Map<String,dynamic> contentData={};
  bool loadingData=false;
  Future addContent(){
    setState(() {
      loadingData=true;
    });
   return HttpHelper.postData( url: 'content/create',body: {
      'name':contentNameCtrl.text,
      'course_id':'${widget.courseId}',
      'url':urlCtrl.text,
      'type':type,
    }).then((value) {
      print(jsonDecode(value.body));
      if(value.statusCode==200||value.statusCode==201){
        setState(() {
          contentData=jsonDecode(value.body);
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return myContents();
            }));
        Get.snackbar('Add content', 'Add content is done .. please refresh app th show it',colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green,);

      }else{}
      setState(() {
        loadingData=false;
      });
    }).catchError((e){
      print(e.toString());
      setState(() {
        loadingData=false;
      });
    });
  }
}
