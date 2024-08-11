import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/models/course/cources.dart';
import 'package:learningapp/screen/Blog/get_posts.dart';
import 'package:learningapp/screen/chating_screen.dart';
import 'package:learningapp/screen/favorit_screen.dart';
import 'package:learningapp/screen/library_screen.dart';
import 'package:learningapp/screen/live_screen.dart';
import 'package:learningapp/screen/setting_screen.dart';
import 'package:learningapp/screen/testMySelf/test_myself.dart';
import '../data/http.dart';
import '../data/models/doc/doc.dart';
import 'allcategory_screen.dart';
import 'category_screen.dart';
import 'cources_screen.dart';
import 'documentation_screen.dart';
import 'library/get_library_content.dart';
import 'saerch_screen.dart';
import 'time_controller.dart';
import 'vedio_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  static String id = "HomePage";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  TabController? _tabController;
  PageController _mainPageController = PageController(initialPage: 0);
  PageController _imagePageController = PageController();
  int _currentIndex = 0;

  final List<String> _imageList = [
    'assets/images/advertisements.png',
    'assets/images/advertisements.png',
    'assets/images/advertisements.png'
  ];

  late Course course;
  late Docs docs;
  bool isLoadingCourses = true;
  bool isLoadingDocs = true;
  Map<String, dynamic> get_my_xp = {};
  final TimeController timeController = Get.put(TimeController());

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 10));
    getAllCourse();
    getAllDocs();
    fetchMyXp();
    _tabController = TabController(length: 4, vsync: this);
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_imagePageController.hasClients) {
        _currentIndex = (_imagePageController.page!.toInt() + 1) % _imageList.length;
        _imagePageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _mainPageController.dispose();
    _imagePageController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      body: PageView(
        controller: _mainPageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Get.to(Setting());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 1.5),
                      child: IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Get.to(SearchPage());
                        },
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.hourglass_bottom_outlined,
                              color: Kcolor,
                              size: 25,
                            ),
                          ),
                          onTap: () {
                            Get.defaultDialog(
                              title: 'لقد قضيت',
                              middleTextStyle: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              content: Obx(() {
                                int seconds = timeController.secondsElapsed.value;
                                double progress = seconds / 300.0; // النسبة الصحيحة للتقدم على مدار 300 ثانية

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Text(
                                              '${(timeController.minutesElapsed.value ~/ 60).toInt()}',
                                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                            ),
                                            Positioned(
                                              left: -20,
                                              bottom: 5,
                                              child: Text(
                                                'سا',
                                                style: TextStyle(fontSize: 14, color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 130),
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Text(
                                              '${(timeController.minutesElapsed.value % 60).toInt()}',
                                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                            ),
                                            Positioned(
                                              left: -10,
                                              bottom: 5,
                                              child: Text(
                                                'د',
                                                style: TextStyle(fontSize: 14, color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          child: CustomPaint(
                                            painter: ProgressPainter(progress: progress),
                                          ),
                                        ),
                                        Positioned(
                                          child: Text(
                                            '${60 - (seconds % 60)}', // عرض الثواني المتبقية في الدورة الحالية
                                            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ),
                                        Positioned(
                                          left: 55,
                                          bottom: 5,
                                          child: Text(
                                            'ث',
                                            style: TextStyle(fontSize: 18, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'من النقاط',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${timeController.points}',
                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          'لديك',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                              confirm: TextButton(
                                child: Text('موافق'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            );
                          },
                        )



                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          FontAwesomeIcons.coins,
                          color: Color(0xFF399679),
                          size: 25,
                        ),
                      ),
                      onTap: () {
                        Get.defaultDialog(
                          title: 'رصيد نقاطك الحالي ',
                          middleTextStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Kcolor, // تأكد من تعريف Kcolor
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 30,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return LinearGradient(
                                              colors: [ Colors.lightGreenAccent,Kcolor], // تغيير الألوان حسب الرغبة
                                              tileMode: TileMode.mirror,
                                            ).createShader(bounds);
                                          },
                                          child: Text(
                                            '${get_my_xp['data']['Your xp is :'].toString()}',
                                            style: TextStyle(
                                              fontSize: 38,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text('XP',style: TextStyle(color: Kcolor,fontSize: 38,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 25.0),
                                        child: TextButton(
                                          child: Text('موافق'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap:(){Get.to(()=>Library());},
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 25.0),
                                          child: Text(
                                            'استبدال',
                                            style: TextStyle(color: Kcolor), // تأكد من تعريف Kcolor
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )


                  ],
                  pinned: false,
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100.0,
                    child: PageView.builder(
                      controller: _imagePageController,
                      itemCount: _imageList.length,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            _imageList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                      labelColor: Color(0xFF399679),
                      unselectedLabelColor: Colors.grey,
                      controller: _tabController,
                      labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      tabs: [
                        Tab(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Kcolor, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                            child: Text("all"),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: 99,
                            decoration: BoxDecoration(
                              border: Border.all(color: Kcolor, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                            child: Text("courses"),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: 99,
                            decoration: BoxDecoration(
                              border: Border.all(color: Kcolor, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: Text(
                              "video",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Kcolor, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Text("pdf"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: isLoadingCourses || isLoadingDocs
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
              controller: _tabController,
              children: [
                allCategory(),
                Cources(course.data),
                Vedio(),
                documentation(docs.data),
              ],
            ),
          ),
          Category(),
          TestMySelf(),
          LiveScreen(),
          ChattingScreen(),
          GetPosts()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Kcolor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _mainPageController.animateToPage(
              index,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.whatsapp),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fileAlt),
            label: 'Blog',
          ),
        ],
      ),
    );
  }

  Future<void> getAllCourse() async {
    var response = await HttpHelper.gettData(url: 'Home/Getcourses_tapbar');
    if (response.statusCode == 200) {
      setState(() {
        course = Course.fromJson(json.decode(response.body));
        isLoadingCourses = false;

        if (course.data.isNotEmpty) {
          print("Test ${course.data[0].name}");
        } else {
          print("No courses available");
        }
      });
    }
  }

  Future<void> getAllDocs() async {
    var response = await HttpHelper.gettData(url: 'Home/Getdocuments_tapbar');
    if (response.statusCode == 200) {
      setState(() {
        docs = Docs.fromJson(json.decode(response.body));
        isLoadingDocs = false;

        if (docs.data.isNotEmpty) {
          print("Test ${docs.data[0].name}");
        } else {
          print("No documents available");
        }
      });
    }
  }

  fetchMyXp() async {
    try {
      final response = await HttpHelper.gettData(url: 'sidebar/getmyXPs');
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          get_my_xp = jsonDecode(response.body);
        });
        print('${get_my_xp['data']['Your xp is :'].toString()}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
class ProgressPainter extends CustomPainter {
  final double progress; // النسبة المئوية من 0 إلى 1 تمثل التقدم

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // رسم دائرة الخلفية
    paint.color = Colors.grey[300]!;
    canvas.drawCircle(center, radius, paint);

    // رسم قوس التقدم
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [Colors.green, Colors.red, Colors.yellow, Colors.green],
        stops: [0.0, 0.33, 0.66, 1.0],
        startAngle: 0.0,
        endAngle: 2 * 3.141592653589793,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    double sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}





