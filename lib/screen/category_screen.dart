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
      body: Container(
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2), itemCount: category.length,itemBuilder: (context,i){
          return
            GestureDetector(
              onTap: (){
                setState(() {
                  // images=index;
                });
              },
              child: Container(width:137,decoration: BoxDecoration(
                  color: Color(0xFFF8F8F7),

                  borderRadius: BorderRadius.circular(8)
              ), height: 180,margin: EdgeInsets.only(left: 10,right: 15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0,top: 2.8),
                      child: Container(
                        height: 130,
                        width: 120,
                        alignment: Alignment.center,
                        margin:EdgeInsets.only(left:20,
                          // right: index==images.length -1 ?20:0),
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: Colors.black,
                            // color: index==selectedIndex?Colors.white.withOpacity(0.4):Color(0xFFC68FCE),
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:AssetImage( category[i]['image'])
                            )
                        ),
                        // child:Image.asset( images[index],height: 140,width: 140,)


                      ),
                    ),
                    Text(category[i]["title"],style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    Row(children: [
                      Row(children: [
                        Icon(Icons.auto_fix_high,color: Color(0xFF399679),size: 20,),
                        Text("Author",style: TextStyle(color: Colors.grey),)
                      ],),
                      Spacer(),

                      Row(children: [
                        Text("pdf",style: TextStyle(color: Colors.grey),),
                        Icon(Icons.picture_as_pdf,color: Color(0xFF399679),size: 20,),
                      ],)
                    ],)
                  ],
                ),
              ),
            );
        }),
      ),);


  }
}
