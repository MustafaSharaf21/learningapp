import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/core/constants.dart';
import 'package:learningapp/data/models/course/cources.dart';
import 'package:learningapp/generated/l10n.dart';
import 'package:learningapp/screen/providers/provider.dart';
import 'package:learningapp/screen/setting_screen.dart';
import 'package:provider/provider.dart';
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
  bool  isLoadingCourses=true;
  bool isLoadingDocs=true;

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
          duration: const Duration(milliseconds: 350),
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
                TextButton(
                  onPressed: () {
                    Provider.of<dProvider>(context, listen: false)
                        .setLanguage('ar');
                    //setState(() {});
                    //Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).Arabic,
                    style: const TextStyle(color: Kcolor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<dProvider>(context, listen: false)
                        .setLanguage('en');
                    //setState(() {});
                    //Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).English,
                    style: const TextStyle(color: Kcolor),
                  ),
                ),
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
                          border: Border.all(color: Kcolor,width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        child: Text(S.of(context).All),
                      ),
                    ),
                    Tab(
                      child: Container(width: 99,
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolor,width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                        child: Text(S.of(context).courses),
                      ),
                    ),
                    Tab(
                      child: Container(width: 99,
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolor,width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text(S.of(context).video,
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
                        EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text(S.of(context).Pdf),
                      ),
                    ),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: isLoadingCourses ||isLoadingDocs
        ?Center(child: CircularProgressIndicator(),)
            :TabBarView(
          controller: _tabController,
          children: [
            allCategory(),
            Cources(course.data),
            Vedio(),
            documentation(docs.data),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 50,
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
            label: S.of(context).Home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite, size: 20),
            selectedIcon: const Icon(Icons.favorite),
            label: S.of(context).Favorite,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_library_outlined, size: 20),
            selectedIcon: const Icon(Icons.local_library_outlined),
            label: S.of(context).Library,
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat, size: 20),
            selectedIcon: const Icon(Icons.chat),
            label: S.of(context).Testting,
          ),
          NavigationDestination(
            icon: IconButton(
              icon:  const Icon(
                Icons.video_call_sharp,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LiveScreen(),
                  ),
                );
              },
            ),
            selectedIcon: const Icon(Icons.video_call_sharp),
            label: S.of(context).Live,
          ),
          NavigationDestination(
            icon: IconButton(
              icon:  const Icon(
                Icons.chat,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChattingScreen(),
                  ),
                );
              },
            ),

            selectedIcon: const Icon(Icons.chat),
            label:S.of(context).Chatting,
          ),
        ],
      ),
    );
  }

  Future<void> getAllCourse() async {
    var response = await HttpHelper.gettData(url:'course/show/1' );
   /* var response = await http.get(
      Uri.parse('http://192.168.43.63:8000/api/course/show/1'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );*/
    if (response.statusCode == 200) {
      setState(() {
        course = Course.fromJson(json.decode(response.body));
        isLoadingCourses=false;
        print("Test ${course.data?[0].name}");
      });
    }
  }

  Future<void> getAllDocs() async {
    var response = await HttpHelper.gettData(url:'Home/Getdocuments_tapbar' );
    /*var response = await http.get(
      Uri.parse('http://192.168.43.63:8000/api/Home/Getdocuments_tapbar'),
      headers: {"Authorization": "Bearer $token"},
    );*/
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
