import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learningapp/data/models/Getx_Controller.dart';
import 'package:learningapp/generated/l10n.dart';
import '../core/constants.dart';
import '../data/http.dart';
import 'create_live.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class LiveScreen extends StatefulWidget {
  static String id = " LiveScreen";
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  TextEditingController controller = TextEditingController();

  List<dynamic> live = [];

  @override
  void initState() {
    fetchLive();
    super.initState();
  }
/*

  @override
  Widget build(BuildContext context) {
    final roleId = Get.find<UserRoleController>().roleId.value;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          roleId == 2
              ? IconButton(
               onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateLive(),
                  ),
                );
              },
               icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
              :const SizedBox.shrink(),
        ],
        backgroundColor: Kcolor,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          S.of(context).Live,
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: live.isNotEmpty
          ? ListView.builder(
           itemCount: live.length,
           itemBuilder: (context, index) {
           var liveItem = live[index];
            return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               height: 180,
               width: 390,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 40, color: Colors.grey, spreadRadius: 0)
              ]),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                   const Icon(
                                      Icons.date_range,
                                      size: 15,
                                      color: Kcolor,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      liveItem['date_start'] ?? '',
                                      style:const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 15,
                                      color: Kcolor,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      liveItem['time_start'] ?? '',
                                      style:const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 210,
                                  child: Center(
                                    child: Text(
                                      liveItem['title'] ?? '',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          const Column(
                            children: [
                              Icon(
                                Icons.live_tv,
                                size: 40,
                                color: Kcolor,
                              ),
                              Text(
                                "google meet",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 7),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final code = liveItem['code'] ?? '';
                              Clipboard.setData(
                                  ClipboardData(text: code));
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content:
                                    Text(S.of(context).Link_copied_to_clipboard)),
                              );
                            },
                            child:  Row(
                              children: [
                                const Icon(
                                  Icons.link,
                                  size: 25,
                                  color: Kcolor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  S.of(context).Copy_The_Live_Link,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Kcolor,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 20,
                            color: Kcolor,
                          ),
                          const SizedBox(width: 3),
                          SizedBox(
                            height: 20,
                            width: 150,
                            child: Text(
                              liveItem['user'] ?? '',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                              height: 20,
                              width: 170,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    liveItem['specialization'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
*/
  /*@override
  Widget build(BuildContext context) {
    return GetBuilder<UserRoleController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            actions: [
              controller.roleId.value == 2
                  ? GestureDetector(
                    child: const Icon(
                     Icons.add,
                     color: Colors.white,
                      ),
                   onTap: () {
                     Get.offAll(() =>CreateLive());
                     *//*Navigator.push(
                     context,
                      MaterialPageRoute(
                       builder: (context) =>  CreateLive(),
                    ),
                  );*//*
                },
              )
                  : const SizedBox.shrink(),
             *//* IconButton(
                onPressed: () {
                  Get.to(() => CreateLive());
                  *//**//*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateLive(),
                    ),
                  );*//**//*
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )*//*

            ],
            backgroundColor: Kcolor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              S.of(context).Live,
              style: const TextStyle(
                  color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          body: live.isNotEmpty
              ? ListView.builder(
            itemCount: live.length,
            itemBuilder: (context, index) {
              var liveItem = live[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180,
                  width: 390,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 40, color: Colors.grey, spreadRadius: 0)
                  ]),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        size: 15,
                                        color: Kcolor,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        liveItem['date_start'] ?? '',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 15,
                                        color: Kcolor,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        liveItem['time_start'] ?? '',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 210,
                                    child: Center(
                                      child: Text(
                                        liveItem['title'] ?? '',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                              const Column(
                                children: [
                                  Icon(
                                    Icons.live_tv,
                                    size: 40,
                                    color: Kcolor,
                                  ),
                                  Text(
                                    "google meet",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 7),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  final code = liveItem['code'] ?? '';
                                  Clipboard.setData(
                                      ClipboardData(text: code));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(S
                                          .of(context)
                                          .Link_copied_to_clipboard),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.link,
                                      size: 25,
                                      color: Kcolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      S.of(context).Copy_The_Live_Link,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Kcolor,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 20,
                                color: Kcolor,
                              ),
                              const SizedBox(width: 3),
                              SizedBox(
                                height: 20,
                                width: 150,
                                child: Text(
                                  liveItem['user'] ?? '',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                width: 170,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      liveItem['specialization'] ?? '',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          Obx(() {
            final roleId = Get.find<UserRoleController>().roleId.value;
            print('roleId------------------: $roleId');
            return roleId == 2
                ? IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateLive(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
                : const SizedBox.shrink();
          }),
        ],
        backgroundColor: Kcolor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).Live,
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: live.isNotEmpty
          ? ListView.builder(
        itemCount: live.length,
        itemBuilder: (context, index) {
          var liveItem = live[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              width: 390,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 40, color: Colors.grey, spreadRadius: 0)
              ]),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.date_range,
                                    size: 15,
                                    color: Kcolor,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    liveItem['date_start'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 15,
                                    color: Kcolor,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    liveItem['time_start'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 210,
                                child: Center(
                                  child: Text(
                                    liveItem['title'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          const Column(
                            children: [
                              Icon(
                                Icons.live_tv,
                                size: 40,
                                color: Kcolor,
                              ),
                              Text(
                                "google meet",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 7),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final code = liveItem['code'] ?? '';
                              Clipboard.setData(
                                  ClipboardData(text: code));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S
                                      .of(context)
                                      .Link_copied_to_clipboard),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.link,
                                  size: 25,
                                  color: Kcolor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  S.of(context).Copy_The_Live_Link,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Kcolor,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 20,
                            color: Kcolor,
                          ),
                          const SizedBox(width: 3),
                          SizedBox(
                            height: 20,
                            width: 150,
                            child: Text(
                              liveItem['user'] ?? '',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  liveItem['specialization'] ?? '',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }


  fetchLive() async {
    try {
      final response = await http.get(
        Uri.parse('$baseurl'+'live/getlives'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}'); // طباعة الاستجابة الكاملة
        var responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          setState(() {
            live = responseData['data'];
          });
          Get.snackbar(
            'Success',
            'Data fetched successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white,
          );
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
