import 'package:flutter/material.dart';

import '../core/constants.dart';

class Category extends StatefulWidget {
  static String id = "Category";
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List category = [
    {"title": "Data Science", "image": "assets/images/dataScience.png"},
    {"title": "Cyber Security", "image": "assets/images/cyberSecurity.png"},
    {"title": "Web Development", "image": "assets/images/webDevelopment.png"},
    {"title": "Artifical Intelligence", "image": "assets/images/artificalIntelligence.png"},
    {"title": "Software Engineering", "image": "assets/images/softwareEngineering.png"},
    {"title": "UI/UX", "image": "assets/images/ui-ux.webp"},
    {"title": "Database Administration", "image": "assets/images/databaseAdministration.png"},
    {"title": "Network Administration", "image": "assets/images/networkAdministration.png"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Category"),backgroundColor: Kcolor,),
      body: Container(padding: EdgeInsets.only(top: 8),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisSpacing: 5,mainAxisSpacing: 30,crossAxisCount: 3), itemCount: category.length,itemBuilder: (context,i){
          return
            GestureDetector(
              onTap: (){
                setState(() {
                  // images=index;
                });
              },
              child: Container(decoration: BoxDecoration(
                  color: Color(0xFFF8F8F7),

                  borderRadius: BorderRadius.circular(8)
              ), height: 180,margin: EdgeInsets.only(left: 0,right: 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0,top: 2.8),
                      child: SizedBox(height: 70,width: 70,
                        child: Container(
                          height: 130,
                          //width: 120,
                          alignment: Alignment.center,
                          margin:EdgeInsets.only(left:0,
                            // right: index==images.length -1 ?20:0),
                          ),
                          // padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(color: Colors.transparent,
                              // color: index==selectedIndex?Colors.white.withOpacity(0.4):Color(0xFFC68FCE),
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(scale: 0.3,
                                  fit: BoxFit.cover,
                                  image:AssetImage( category[i]['image'],)
                              )
                          ),
                          // child:Image.asset( images[index],height: 140,width: 140,)


                        ),
                      ),
                    ),
                    Text(category[i]["title"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            );
        }),
      ),);


  }
}
