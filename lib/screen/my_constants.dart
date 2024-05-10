// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class myContents extends StatefulWidget {
//   const myContents({Key? key}) : super(key: key);
//
//   @override
//   State<myContents> createState() => _CourcesState();
// }
//
// class _CourcesState extends State<myContents> {
//
//   List images =[
//     "assets/images/pdf.jpg",
//     "assets/images/pdf.jpg",
//     "assets/images/pdf.jpg",
//     "assets/images/pdf.jpg",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar:AppBar(title: Text("My Contents"),actions: [
//       Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Icon(Icons.more_vert),
//       )
//       ],)
//         ,body:
//         ListView.builder(scrollDirection: Axis.vertical,
//         itemCount: images.length,
//         itemBuilder: (context, index) =>
//         Padding(
//           padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
//           child: Container(height: 118,
//             decoration: BoxDecoration(border:Border.all(color: Colors.black12),borderRadius: BorderRadius.circular(17) )
//             ,child: Padding(
//               padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8,bottom: 8),
//                     child: Column(mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                               PopupMenuButton<String>(
//                                 onSelected: (String value){
//                                   if (value =='add'){}
//                                   else{
//
//                                   }
//                                 },itemBuilder: (BuildContext context)=><PopupMenuEntry<String>>[
//                                   const PopupMenuItem<String>(
//                                     value: 'add',
//                                     child: Text('اضافة'),
//                                   ),
//                                 const PopupMenuItem<String>(
//                                   value: 'edit',
//                                   child: Text('تعديل'),
//                                 ),
//                               ],
//                            icon:Icon(Icons.more_vert),
//                                 color: Colors.white,
//                                 offset: Offset(0,40),
//                               )
//                             ,
//                             Padding(padding: EdgeInsets.only(left: 55),child: Text('Title',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),)),
//
//                           ],
//                         ),
//                         SizedBox(height: 5,),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 12.5),
//                           child: Text('here we will put description',style: TextStyle(color: Colors.grey[600],fontSize: 12),),
//                         ),
//                         Spacer(),
//                         Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(Icons.lock_clock_outlined,size: 20,color: Color(0xffEC7D7F),),
//                             SizedBox(width: MediaQuery.of(context).size.width*0.30,),
//                             Text("author")
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   Spacer(flex: 15,),
//                   Padding(
//                     padding: const EdgeInsets.only(top:8.0),
//                     child: Container(height: 190,
//                         width: 90,
//                         child: Image.asset("assets/2.jpg")),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//     ));
//   }}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants.dart';


class myContents extends StatefulWidget {
  @override
  _MyComponentPageState createState() => _MyComponentPageState();
}

class _MyComponentPageState extends State<myContents> {
  List<bool> selectedComponents = List.generate(10, (index) => false);
  bool showCheckboxes = false;

  void selectAll() {
    setState(() {
      for (int i = 0; i < selectedComponents.length; i++) {
        selectedComponents[i] = true;
      }
      showCheckboxes = true; // عرض مربعات الاختيار
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Content', style: TextStyle(color: Colors.black)),
        backgroundColor: Kcolor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'select_all') {
                selectAll();
              }
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'select_all',
                child: Text('select all'),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('delete'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: selectedComponents.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Row(
                children: [
                  if (showCheckboxes) ...[
                    Checkbox(
                      value: selectedComponents[index],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedComponents[index] = value!;
                        });
                      },
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            PopupMenuButton<String>(
                              onSelected: (String value) {
                                if (value == 'Add') {
                                  //  selectAll();
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Add',
                                  child: Text('Add'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Text('edit'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('delete'),
                                ),
                              ],
                            ),
                            // SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                            Text(
                              'Title $index',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'here we will put description',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/2.jpg", fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}