import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/models/course/cources.dart';
import 'package:learningapp/screen/setting_screen.dart';
import '../data/http.dart';
import '../data/models/doc/doc.dart';
import 'allcategory_screen.dart';
import 'cources_screen.dart';
import 'documentation_screen.dart';
import 'saerch_screen.dart';
import 'vedio_screen.dart';
import 'package:http/http.dart' as http;

<<<<<<< HEAD
=======
// void main() => runApp(HomePage());
>>>>>>> ed6238242aad5b0ebf252ce9435b2024f26ef421

// class HomePage extends StatelessWidget {
//   static String id = "HomePage";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static String id = "HomePage";
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController? _tabController;
  PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<String> _imageList = [
    'assets/images/advertisements.png',
    'assets/images/advertisements.png',
    'assets/images/advertisements.png'
  ];
<<<<<<< HEAD
  late Course course;
  late Docs docs;
  bool courseLoading=true;
  bool docsLoading=true;
=======
  Map<String, dynamic> course = {};
  Map<String, dynamic> docs = {};

>>>>>>> ed6238242aad5b0ebf252ce9435b2024f26ef421
  @override
  void initState() {
    getAllCourse();
    getAllDocs();
<<<<<<< HEAD
    super.initState();
=======
>>>>>>> ed6238242aad5b0ebf252ce9435b2024f26ef421

    _tabController = TabController(length: 4, vsync: this);
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        _currentIndex = (_pageController.page!.toInt() + 1) % _imageList.length;
        _pageController.animateToPage(
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      body: NestedScrollView(
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
                Expanded(
                  child: Container(),
                ),
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
                  controller: _pageController,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 8),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text(
                          "video",
                          style:
                              TextStyle(fontSize: 14), // تحديد حجم الكلمة هنا
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolor, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
        body: TabBarView(
          controller: _tabController,
          children: [
            allCategory(),
<<<<<<< HEAD
            courseLoading==true?Center(child: CircularProgressIndicator(),):
            Cources(course.data),
            Vedio(),
            docsLoading==true?Center(child: CircularProgressIndicator(),): documentation(docs.data),
=======
            courseLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Cources(course['data']),
            Vedio(),
            // loadingDocs == true
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : documentation(docs['date']),
>>>>>>> ed6238242aad5b0ebf252ce9435b2024f26ef421
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 80,
        indicatorColor: Color(0xFF399679),
        backgroundColor: Colors.white,
        elevation: 0,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home, size: 20),
            selectedIcon: const Icon(Icons.home),
            label: "home",
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite, size: 20),
            selectedIcon: const Icon(Icons.favorite),
            label: "favorite",
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_library_outlined, size: 20),
            selectedIcon: const Icon(Icons.local_library_outlined),
            label: "library",
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat, size: 20),
            selectedIcon: const Icon(Icons.chat),
            label: "Test mySelf",
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Future<void> getAllCourse() async {
    var response = await http.get(
      Uri.parse('http://192.168.1.6:8000/api/course/show/1'),
      headers: {
        "Authorization": "Bearer ${box.read('token')}",
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        course = Course.fromJson(json.decode(response.body));
        courseLoading=false;
        print("Test ${course.data.toString()}");
      });
    }
  }

  Future<void> getAllDocs() async {

    var response = await http.get(
      Uri.parse('http://192.168.1.6:8000/api/Home/Getdocuments_tapbar'),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      setState(() {
        docs = Docs.fromJson(json.decode(response.body));
        docsLoading=false;
        print("Test ${docs.data[0].name}");
      });
    }
=======
  bool courseLoading = true;
  Future getAllCourse() async {
    await HttpHelper.gettData(
      url: 'Home/Getcourses_tapbar',
    ).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          course = jsonDecode(value.body);
          print("Test ${value.body}");
        });
        setState(() {
          courseLoading = false;
        });
      }
    });
  }

  bool loadingDocs = true;
  Future getAllDocs() async {
    await HttpHelper.gettData(
      url: 'Home/Getdocuments_tapbar',
    ).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          docs = jsonDecode(value.body);
          // print("Test ${docs['data'][0].name}");
        });
        setState(() {
          loadingDocs = false;
        });
      }
    });
>>>>>>> ed6238242aad5b0ebf252ce9435b2024f26ef421
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
