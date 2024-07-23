import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/models/course/cources.dart';
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
import 'saerch_screen.dart';
import 'vedio_screen.dart';
import 'package:http/http.dart' as http;

void main() => runApp(HomePage());

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

  @override
  void initState() {
    super.initState();
    getAllCourse();
    getAllDocs();
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
                    Text("Eline"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Color(0xFF399679),
                        ),
                        onTap: () {},
                      ),
                    ),
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
          Library(),
          TestMySelf(),
          LiveScreen(),
          ChattingScreen()
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
            icon: Icon(Icons.local_library_outlined),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Test Myself',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_sharp),
            label: 'chating',
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
