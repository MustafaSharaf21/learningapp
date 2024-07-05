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
import 'chating_screen.dart';
import 'cources_screen.dart';
import 'documentation_screen.dart';
import 'live_screen.dart';
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
  PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<String> _imageList = [
    'assets/images/advertisements.png',
    'assets/images/advertisements.png',
    'assets/images/advertisements.png'
  ];
  late Course course;
  late Docs docs;
  bool isLoadingDocs=true;
  bool isLoadingCourses=true;

  @override
  void initState() {
    super.initState();
    getAllCourse();
    getAllDocs();
    _tabController = TabController(length: 4, vsync: this);
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        _currentIndex = (_pageController.page!.toInt() + 1) % _imageList.length;
        _pageController.animateToPage(
          _currentIndex,
          duration:const  Duration(milliseconds: 350),
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
      backgroundColor: const Color(0xFFEAEAEA),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: IconButton(
                    icon:const  Icon(Icons.settings),
                    onPressed: () {
                      Get.to(Setting());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1.5),
                  child: IconButton(
                    icon:const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: IconButton(
                    icon:const Icon(Icons.search),
                    onPressed: () {
                      Get.to(SearchPage());
                    },
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                const Text("Eline"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    child:const CircleAvatar(
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
                    padding: const EdgeInsets.all(8),
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
                  indicator:const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                  ),
                  labelColor:const Color(0xFF399679),
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  labelPadding:const EdgeInsets.symmetric(horizontal: 8.0),
                  tabs: [
                    Tab(
                      child: Container(
                        width: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolor,width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        child:const Text("all"),
                      ),
                    ),
                    Tab(
                      child: Container(width: 99,
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolor,width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                        child:const Text("courses"),
                      ),
                    ),
                    Tab(
                      child: Container(width: 99,
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolor,width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child:const Text(
                          "video",
                          style: TextStyle(fontSize: 14), // تحديد حجم الكلمة هنا
                        ),
                      ),
                    ),

                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolor,width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child:const Text("pdf"),
                      ),
                    ),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body:isLoadingCourses ||isLoadingDocs
        ? const Center(child: CircularProgressIndicator(),)
        :TabBarView(
          controller: _tabController,
          children: [
            const allCategory(),
            Cources(course.data),
            const Vedio(),
            documentation(docs.data),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 50,
        indicatorColor: const Color(0xFF399679),
        backgroundColor: Colors.white,
        elevation: 0,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        destinations: [
          const NavigationDestination(
            icon:  Icon(Icons.home, size: 20),
            selectedIcon:  Icon(Icons.home),
            label: "home",
          ),
          const NavigationDestination(
            icon:  Icon(Icons.favorite, size: 20),
            selectedIcon:  Icon(Icons.favorite),
            label: "favorite",
          ),
          const NavigationDestination(
            icon:  Icon(Icons.local_library_outlined, size: 20),
            selectedIcon: Icon(Icons.local_library_outlined),
            label: "library",
          ),
          NavigationDestination(
            icon:
            IconButton(onPressed:() {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ChattingScreen(),));},
              icon:const Icon(Icons.chat, size:20),
            ),
            selectedIcon:const Icon(Icons.chat),
            label: "Chatting",

          ),
          NavigationDestination(
            icon:
                 IconButton(onPressed:() {
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LiveScreen(),));},
                          icon:const Icon(Icons.video_call_sharp, size:20),
                          ),
            selectedIcon:const Icon(Icons.video_call_sharp),
            label: "Live",

          ),
        ],
      ),
    );
  }

  Future<void> getAllCourse() async {

    var response = await HttpHelper.gettData(url: 'course/show/1');
    if (response.statusCode == 200) {
      setState(() {
        course = Course.fromJson(json.decode(response.body));
        isLoadingCourses=false;
        print("Test ${course.data[0].name}");
      });
    }
  }

  Future<void> getAllDocs() async {
    var response = await HttpHelper.gettData(url: 'Home/Getdocuments_tapbar');
    if (response.statusCode == 200) {
      setState(() {
        docs = Docs.fromJson(json.decode(response.body));
        isLoadingDocs=false;
        print("Test ${docs.data[0].name}");
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
