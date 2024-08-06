import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learningapp/data/models/Getx_Controller.dart';
import 'package:learningapp/generated/l10n.dart';
import 'package:learningapp/screen/Content_management.dart';
import 'package:learningapp/screen/profile/profile.dart';
import '../LanguageCubit/language_cubit.dart';
import '../core/constants.dart';
import '../data/http.dart';
import '../data/models/Themes.dart';
import 'login_screen.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String dropdownValue = 'العربية';
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final roleId = Get.find<UserRoleController>().roleId.value;
    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyText1?.color;
    final Color containerColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: textColor,
        title: Text(
          S.of(context).Setting,
          style:  TextStyle(color: textColor),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF399679),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            roleId == 2
                ? GestureDetector(
              child: Container(
                width: 335,
                height: 50,
                margin: const EdgeInsets.only(
                  left: 40,
                  top: 8,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xD5E5E4E4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 27,
                      height: 60,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(Icons.school, color: iconColor),
                    ),
                    const SizedBox(width: 10),
                     Text(
                      "Content Management",
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ContentManagement(),
                  ),
                );
              },
            )
                : const SizedBox.shrink(),
            GestureDetector(
              child: Container(
                width: 335,
                height: 50,
                margin: const EdgeInsets.only(left: 40, top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xD5E5E4E4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 27,
                      height: 60,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(Icons.person, color: iconColor),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      S.of(context).My_Account,
                      style: TextStyle(color:textColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const profilepage(),
                  ),
                );
              },
            ),
            Container(
              width: 335,
              height: 50,
              margin: const EdgeInsets.only(left: 40, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xD5E5E4E4),
              ),
              child: ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).Close),
                        ),
                      ],
                      title: Text(S.of(context).Language),
                      contentPadding: const EdgeInsets.all(20),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<LanguageCubit>(context).setLanguage("ar");
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text(
                              S.of(context).Arabic,
                              style:  TextStyle(color:textColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<LanguageCubit>(context).setLanguage("en");
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text(
                              S.of(context).English,
                              style:  TextStyle(color: textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                leading: Icon(FontAwesomeIcons.language, color: iconColor),
                title: Text(
                  S.of(context).Language,
                  style:  TextStyle(color: textColor, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 335,
              height: 50,
              margin: const EdgeInsets.only(left: 40, top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xD5E5E4E4),
              ),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 60,
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.dark_mode_rounded, color: iconColor),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).Dark_Mood,
                    style:  TextStyle(color: textColor, fontSize: 18),
                  ),
                  const SizedBox(width: 122),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeColor: const Color(0xFF399679),
                      value: isSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          if (Get.isDarkMode) {
                            Get.changeTheme(Themes.customLightTheme);
                          } else {
                            Get.changeTheme(Themes.customDarkTheme);
                          }
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                width: 335,
                height: 50,
                margin: const EdgeInsets.only(left: 40, top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xD5E5E4E4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 27,
                      height: 60,
                      decoration: BoxDecoration(
                       // color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(Icons.person, color: iconColor),
                    ),
                    const SizedBox(width: 10),
                    Text(
                    " MY_Library",
                      style:  TextStyle(color: textColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const profilepage(),
                  ),
                );
              },
            ),
            Container(
              width: 335,
              height: 60,
              margin: const EdgeInsets.only(left: 40, top: 8),
              child: ListTile(
                trailing: Icon(Icons.logout, color: iconColor),
                onTap: () {
                  Get.defaultDialog(
                    title: S.of(context).Are_you_sure_to_log_out,
                    content: Container(),
                    cancelTextColor: const Color(0xff10AB9E),
                    textConfirm: S.of(context).confirm,
                    buttonColor: const Color(0xff10AB9E),
                    textCancel: S.of(context).cancel,
                    confirmTextColor: Colors.white,
                    onConfirm: () async {
                      await http.post(
                        Uri.parse('$baseurl' + 'logout'),
                        headers: {
                          'Authorization': 'Bearer $token',
                        },
                      ).then((value) {
                        Map<String, dynamic> res = jsonDecode(value.body);
                        print(res['data']);
                        print(token);
                        if (value.statusCode == 200 || value.statusCode == 201) {
                          Get.snackbar('signed out', res['data'],
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                          );
                          Get.offAll(() => LoginPage());
                        } else {
                          print(res);
                          print(token);
                        }
                      });
                    },
                    onCancel: () {
                      Get.back();
                    },
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.grey[300],
                title: Text(
                  S.of(context).log_out,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  S.of(context).click_here_to_log_out,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


