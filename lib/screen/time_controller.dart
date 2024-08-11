import 'dart:convert';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';

import '../core/constants.dart';
import '../data/http.dart'; // استيراد مكتبة just_audio

class TimeController extends GetxController {
  var secondsElapsed = 0.obs;
  var minutesElapsed = 0.obs;
  var points = 0.obs;  // هنا يمكنك تعريف المتغير الذي سيتلقى النقاط من الشبكة
  Timer? _timer;
  late ConfettiController _confettiController;
  late AudioPlayer _audioPlayer;

  @override
  void onInit() {
    super.onInit();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    _audioPlayer = AudioPlayer(); // تهيئة مشغل الصوت
    _startTimer();
    fetchMyXp(); // جلب النقاط من الشبكة عند بدء التشغيل
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsElapsed.value++;

      if (secondsElapsed.value >= 60) {
        secondsElapsed.value = 0;
        minutesElapsed.value++;

        if (minutesElapsed.value % 5 == 0 && minutesElapsed.value != 0) {
          update_my_xp();

          // تشغيل تأثيرات الـ Confetti
          _confettiController.play();

          // تشغيل الصوت
          _audioPlayer.setAsset('assets/sound/duolingo_correct.mp3'); // تأكد من تحديث المسار الصحيح
          _audioPlayer.play();

          Get.defaultDialog(
            title:  '!لقد حصلت على 5 نقاط',
            middleTextStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: -pi / 2,
                  particleDrag: 0.05,
                  emissionFrequency: 0.1,
                  numberOfParticles: 20,
                  gravity: 0.02,
                ),
                SizedBox(height: 20),
                Obx(() {
                  return
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.gem, color: Colors.yellow),
                        SizedBox(width: 8),
                        Text(
                          '${points.value}',  // استخدام النقاط المراقبة هنا
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                }),
              ],
            ),
            confirm: TextButton(
              child: Text('موافق'),
              onPressed: () {
                print("موافق تم النقر عليه");
                Get.back();
              },
            ),
          );
        }
      }

      update(); // استخدم update بحذر لتفادي التحديثات المفرطة
    });
  }

  Future<void> fetchMyXp() async {
    try {
      final response = await HttpHelper.gettData(url: 'sidebar/getmyXPs');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        points.value = data['data']['Your xp is :']; // تحديث النقاط
        print('${points.value}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> update_my_xp() async {
    print("eline ");
    await HttpHelper.postData(
      url: 'sidebar/updatemyxp/5',
    ).then((value) {
      print(" ${value.body}");
      try {
        Map<String, dynamic> res = jsonDecode(value.body);
        print("$res");
        if (value.statusCode == 200 || value.statusCode == 201) {
          print('eline');
          Get.snackbar(
              ' ',
              res['data']['Added to your xp'].toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Kcolor,
              colorText: Colors.white
          );
          print("${res['data']['Added to your xp']}");
        } else {
          Get.snackbar(
              'Error',
              res['status'].toString(),
              backgroundColor: Colors.black,
              colorText: Colors.white
          );
          print(" ${res['status']}");
        }
      } catch (e) {
        print('$e');
        Get.snackbar(
            'Error',
            'هناك خطأ في تحليل البيانات',
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _confettiController.dispose();
    _audioPlayer.dispose(); // تأكد من إغلاق AudioPlayer
    super.onClose();
  }

  String get timeElapsed {
    int hours = (minutesElapsed.value ~/ 60).toInt();
    int minutes = (minutesElapsed.value % 60).toInt();
    int seconds = secondsElapsed.value;
    return '${hours} ساعة, ${minutes} دقيقة, ${seconds} ثانية';
  }
}
