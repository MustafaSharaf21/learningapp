
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/screen/setting_screen.dart';
import 'allcategory_screen.dart';
import 'cources_screen.dart';
import 'documentation_screen.dart';
import 'saerch_screen.dart';
import 'vedio_screen.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  static String id = " HomePage";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
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
    'assets/images/pdf.jpg',
    'assets/images/Log_in.jpg',
    'assets/images/pdf2.jpg'
  ];

  @override
  void initState() {
    super.initState();
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
    return Scaffold(backgroundColor: Color(0xFFEAEAEA),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[

              SliverAppBar(actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child:IconButton(icon:Icon(Icons.settings),onPressed: (){Get.to(Setting());},),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1.5),
                  child: IconButton(icon:Icon(Icons.notifications),onPressed: (){},),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: IconButton(icon:Icon(Icons.search),onPressed: (){Get.to(SearchPage());},),
                ),
                Expanded(child: Container(),),
                Text("Full_Name"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(child: CircleAvatar(backgroundColor: Color(0xFF399679)
                    ,),onTap: (){
                  }
                  ),
                ),



              ],
                pinned: false,
                floating: true,
                snap: true, // Snap the app bar into view or out of view
                forceElevated: innerBoxIsScrolled,
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100.0, // Image height
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _imageList.length,
                    itemBuilder: (context, index) => Container(padding: EdgeInsets.all(8),
                      child: ClipRRect(borderRadius: BorderRadius.circular(10),
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
                  TabBar(indicatorColor: Color(0xFF399679),
                    labelColor: Color(0xFF399679),
                    controller: _tabController,
                    tabs: [
                      Tab(text: "all"),
                      Tab(text:" cources"),
                      Tab(text:" vedio"),
                      Tab(text: "pdf"),
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
              Cources(),
              Vedio(),
              documentation(),
            ],
          ),
        ),
        bottomNavigationBar:
        NavigationBar(
          height: 50,
          indicatorColor: Color(0xFF399679),
          backgroundColor: Colors.white,
          elevation: 0,
          //backgroundColor: Color(0xFFFDFCFC),
          selectedIndex:_currentIndex,
          onDestinationSelected: (index)=>setState(() {
            this._currentIndex=index;
          }),
          destinations: [
            NavigationDestination(icon:const Icon(Icons.home,size: 20),selectedIcon:const Icon(Icons.home),label:" home"),
            NavigationDestination(icon:const Icon(Icons.favorite,size: 20),selectedIcon:const Icon(Icons.favorite),label:"favorite"),
            NavigationDestination(icon:const Icon(Icons.local_library_outlined,size: 20),selectedIcon:const Icon(Icons.local_library_outlined),label:" library" ),
            NavigationDestination(icon:const Icon(Icons.chat,size: 20),selectedIcon:const Icon(Icons.chat),label:"chating"),
          ],


        )
    );
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
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}


