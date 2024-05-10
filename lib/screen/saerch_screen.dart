// import 'package:flutter/material.dart';
//
//
//
// class MyApp extends StatelessWidget {
//   static String id = " LoginPage";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   bool _isSearching = false;
//   final TextEditingController _searchQueryController = TextEditingController();
//
//   void _startSearch() {
//     setState(() {
//       _isSearching = true;
//     });
//   }
//
//   void _stopSearch() {
//     _clearSearchQuery();
//     setState(() {
//       _isSearching = false;
//     });
//   }
//
//   void _clearSearchQuery() {
//     setState(() {
//       _searchQueryController.clear();
//     });
//   }
//
//   Widget _buildSearchField() {
//     return TextField(
//       controller: _searchQueryController,
//       autofocus: true,
//       decoration: InputDecoration(
//         hintText: 'Search...',
//         border: InputBorder.none,
//         hintStyle: TextStyle(color: Colors.white30),
//       ),
//       style: TextStyle(color: Colors.white, fontSize: 16.0),
//       onChanged: (query) => updateSearchQuery(query),
//     );
//   }
//
//   void updateSearchQuery(String newQuery) {
//     // Call your model or state to do the search
//   }
//
//   List<Widget> _buildActions() {
//     if (_isSearching) {
//       return <Widget>[
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             if (_searchQueryController.text.isEmpty) {
//               Navigator.pop(context);
//               return;
//             }
//             _clearSearchQuery();
//           },
//         ),
//       ];
//     }
//
//     return <Widget>[
//       IconButton(
//         icon: const Icon(Icons.search),
//         onPressed: _startSearch,
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _isSearching ? _buildSearchField() : Text('Demo'),
//         actions: _buildActions(),
//       ),
//       body: Container(
//         // Your body content
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
//
// import 'allcategory_screen.dart';
// import 'profile/profile_screen.dart';
// import 'setting_screen.dart';
//
// class test extends StatelessWidget {
//   static String id = " test";
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
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   late TabController _tabController2;
//   bool _isSearching = false;
//   TextEditingController _searchQueryController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     _searchQueryController.dispose();
//     super.dispose();
//   }
//
//   void _startSearch() {
//     ModalRoute.of(context)
//         ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
//     setState(() {
//       _isSearching = true;
//     });
//   }
//
//   void _stopSearching() {
//     _clearSearchQuery();
//     setState(() {
//       _isSearching = false;
//     });
//   }
//
//   void _clearSearchQuery() {
//     setState(() {
//       _searchQueryController.clear();
//     });
//   }
//
//   TabController? _tabController;
//   PageController _pageController = PageController();
//   int _currentIndex = 0;
//   final List<String> _imageList = [
//     'assets/images/pdf.jpg',
//     'assets/images/Log_in.jpg',
//     'assets/images/pdf2.jpg'
//   ];
//
//   @override
//   void initState1() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       if (_pageController.hasClients) {
//         _currentIndex = (_pageController.page!.toInt() + 1) % _imageList.length;
//         _pageController.animateToPage(
//           _currentIndex,
//           duration: Duration(milliseconds: 350),
//           curve: Curves.easeIn,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose1() {
//     _tabController?.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFFEAEAEA),
//         body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                   title: _isSearching
//                       ? TextField(
//                           controller: _searchQueryController,
//                           autofocus: true,
//                           decoration: InputDecoration(
//                             hintText: 'Search...',
//                             border: InputBorder.none,
//                           ),
//                           onSubmitted: (value) {
//                             // هنا يمكنك تنفيذ منطق البحث
//                           },
//                         )
//                       : null, // لا نعرض شيئاً في العنوان
//                   actions: _isSearching
//                       ? [
//                           IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () {
//                               _stopSearching();
//                             },
//                           ),
//                         ]
//                       : [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 4.0),
//                             child: IconButton(
//                               icon: Icon(Icons.settings),
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => Setting(),
//                                     ));
//                                 ;
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 1.5),
//                             child: IconButton(
//                               icon: Icon(Icons.notifications),
//                               onPressed: () {},
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 2),
//                             child: IconButton(
//                               icon: const Icon(Icons.search),
//                               onPressed: _startSearch,
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(),
//                           ),
//                           Text("Eline Faramnd"),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: GestureDetector(
//                                 child: CircleAvatar(
//                                   backgroundColor: Color(0xFF399679),
//                                 ),
//                                 onTap: () {}),
//                           ),
//                         ],
//                   pinned: true,
//                   floating: true,
//                   forceElevated: innerBoxIsScrolled),
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 100.0, // Image height
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: _imageList.length,
//                     itemBuilder: (context, index) => Container(
//                       padding: EdgeInsets.all(8),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset(
//                           _imageList[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SliverPersistentHeader(
//                 delegate: _SliverAppBarDelegate(
//                   TabBar(
//                     indicatorColor: Color(0xFF399679),
//                     labelColor: Color(0xFF399679),
//                     controller: _tabController,
//                     tabs: [
//                       Tab(text: 'All'),
//                       Tab(text: 'cources'),
//                       Tab(text: 'EEE'),
//                     ],
//                   ),
//                 ),
//                 pinned: true,
//               ),
//             ];
//           },
//           body: TabBarView(
//             controller: _tabController,
//             children: [
//               allCategory(),
//               Center(child: Text('Courses')),
//               Center(child: Text('EEE'))
//             ],
//           ),
//         ),
//         bottomNavigationBar: NavigationBar(
//           height: 50,
//           indicatorColor: Color(0xFF399679),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           //backgroundColor: Color(0xFFFDFCFC),
//           selectedIndex: _currentIndex,
//           onDestinationSelected: (index) => setState(() {
//             this._currentIndex = index;
//           }),
//           destinations: const [
//             NavigationDestination(
//                 icon: Icon(Icons.home, size: 20),
//                 selectedIcon: Icon(Icons.home),
//                 label: "home"),
//             NavigationDestination(
//                 icon: Icon(Icons.favorite, size: 20),
//                 selectedIcon: Icon(Icons.favorite),
//                 label: "favorite"),
//             NavigationDestination(
//                 icon: Icon(Icons.local_library_outlined, size: 20),
//                 selectedIcon: Icon(Icons.local_library_outlined),
//                 label: "library"),
//             NavigationDestination(
//                 icon: Icon(Icons.chat, size: 20),
//                 selectedIcon: Icon(Icons.chat),
//                 label: "chating"),
//           ],
//         ));
//   }
// }
//
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);
//
//   final TabBar _tabBar;
//
//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new Container(
//       color: Colors.white,
//       child: _tabBar,
//     );
//   }
//
//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/screen/filtering.dart';

import '../core/constants.dart';
//
// class SearchPage extends StatefulWidget {
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   List<String>CountryList=['Afghanistan',' Albania', ' Algeria',' Andorra',' Angola','Antigua and Barbuda',' Argentina',
//     'Armenia''Australia','Austria','Austrian Empire*',' Azerbaijan','Baden',' Bahamas', 'Bahrain','Bangladesh',' Barbados'
//     ,'Bavaria',' Belarus','Belgium','Belize','Benin (Dahomey)', 'Bolivia','Bosnia and Herzegovina','Botswana',' Brazil','Brunei'
//     ,' Brunswick and Lüneburg',' Bulgaria','Burkina Faso (Upper Volta)','Burma','Burundi', 'CabonVerde',' Cambodia',' Cameroon'
//     ,' Canada',' Cayman Islands','Central African Republic',' Central American Federation*',' Chad',' Chile', 'China',' Colombia',
//     'Comoros',' Congo Free State, The*','Costa Rica', 'Cote d’Ivoire ',' Croatia','Cuba','Cyprus','Czechia','Czechoslovakia'
//   ];
//   List<String>SpecializationList=['Ui','Ux','Frontend Developer','Backend Developer'];
//
//   String? selectedCountry;
//   String? selectedSpecialization;
//   @override
//   Widget build(BuildContext context) {
//               return AlertDialog(contentPadding: EdgeInsets.symmetric(horizontal: 2,vertical: 24),
//                 title: Text('Alert Dialog Title'),
//                 content:
//                Column(mainAxisSize:MainAxisSize.min,children: [
//                  DropdownButton(//padding: EdgeInsets.symmetric(horizontal: 2,vertical: 24),
//                    borderRadius: BorderRadius.circular(2),
//                    underline:const Divider( thickness:0,height:0),
//                    icon:const Icon(Icons.arrow_drop_down, color: Color(0xFF464241),size: 30,),
//                    dropdownColor: Colors.white,
//                    hint:const  Text(
//                      'Country                                            ',
//                      style: TextStyle(
//                          fontSize:15,
//                          color: Color(0xFF464241),
//                          fontFamily:'Cairo'),
//                    ),
//                    items:CountryList.map((item) =>DropdownMenuItem(
//                      value: item,
//                      child: Text(item,
//                        style:const  TextStyle(
//                            fontSize: 15,
//                            color: Colors.black,
//                            fontFamily:'Cairo'),
//                      ),
//                    ),
//                    ).toList(),
//                    onChanged: (item){
//                      setState((){
//                        selectedCountry=item;
//                        // print( selectedGender);
//                      });
//                    },
//                    value: selectedCountry,
//
//                  ),
//                  DropdownButton(padding: EdgeInsets.symmetric(horizontal: 2,vertical: 24),
//                    borderRadius: BorderRadius.circular(30),
//                    underline:const Divider( thickness:0,height:0),
//                    icon:const Icon(Icons.arrow_drop_down, color: Color(0xFF464241),size: 30,),
//                    dropdownColor: Colors.white,
//                    hint:const  Text(
//                      'Specialization                                            ',
//                      style: TextStyle(
//                          fontSize:15,
//                          color: Color(0xFF464241),
//                          fontFamily:'Cairo'),
//                    ),
//                    items:SpecializationList.map((item) =>DropdownMenuItem(
//                      value: item,
//                      child: Text(item,
//                        style:const  TextStyle(
//                            fontSize: 15,
//                            color: Colors.black,
//                            fontFamily:'Cairo'),
//                      ),
//                    ),
//                    ).toList(),
//                    onChanged: (item){
//                      setState((){
//                        selectedSpecialization=item;
//                        // print( selectedGender);
//                      });
//                    },
//                    value: selectedSpecialization,
//
//                  )
//
//                ],)
//               );
//             }
//
//   }


class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        ),
        body: SearchBar(),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();
 List <String> LastFiveSentences =[
   " Sentences one",
   "Sentences two",
   "Sentences three",
   "Sentences four",
  "Sentences five",
 ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
      child:
      Column(children:[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search Here',
                    icon: Icon(Icons.search),
                    suffixIcon: _controller.text.isEmpty
                        ? null
                        : GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        _controller.clear();
                        setState(() {});
                      },
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                Get.to(()=>Filtering());
              },
            ),
          ],
        ),
        Expanded(child:ListView.builder(
          itemCount:LastFiveSentences.length,
          itemBuilder:(context,index){
            return ListTile(title:Text(LastFiveSentences[index]));
          }
        ))
      ])
    );
  }
}