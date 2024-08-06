import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learningapp/generated/l10n.dart';
import '../core/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../data/http.dart';

class ChattingScreen extends StatefulWidget {
  static String id = "ChattingScreen";
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  TextEditingController controller = TextEditingController();
  List<dynamic> chat = [];
  File?image;


  @override
  void initState() {
    fetchChatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Kcolor,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          S.of(context).Chatting,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      body:chat.isNotEmpty
          ? ListView.builder(
            itemCount:chat.length,
            itemBuilder: (context, index) {
            var chatItem = chat[index];
            final chatImage = chatItem['image'] ?? 'assets/images/emptyImage.jpg';
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 390,
                decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 40, color: Colors.grey, spreadRadius: 0)
              ]),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              '$imgURL'+chatImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/emptyImage.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child:
                            Column(
                              children: [
                                    const SizedBox(height: 7,),
                                    SizedBox(
                                      height: 30,
                                      width: 200,
                                      child: Text( chatItem['name'] ?? '',
                                      style:const TextStyle(fontSize: 18,
                                                      color: Colors.black
                                      ),)),
                              ],
                            ),
                      ),
                      GestureDetector(
                              onTap: (){
                                _openWhatsApp(chatItem['mobile_number'] ?? '');
                              },
                              child: const Icon(FontAwesomeIcons.whatsapp,
                                color:Color(0xFF25D366),
                                size: 50,
                              ),),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ): const Center(child: CircularProgressIndicator(),
      ),
    );
  }


  void _openWhatsApp(String phoneN) async {
    String whatsappUrl = "whatsapp://send?phone=+963$phoneN";
    print(whatsappUrl);

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    }else {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Could not open WhatsApp'))
    );
    }
  }

  fetchChatting() async {
    try {
      final response = await http.get(
        Uri.parse('$baseurl'+'chat/getusers'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}'); // طباعة الاستجابة الكاملة
        var responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          setState(() {
            chat= responseData['data'];
          });
          Get.snackbar(
            'Success',
            'Data fetched successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
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



