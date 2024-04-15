import 'package:flutter/material.dart';
class allCategory extends StatefulWidget {
  const allCategory({super.key});

  @override
  State<allCategory> createState() => _exampleState();
}

class _exampleState extends State<allCategory> {

  List images =[
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return    Column(children: [
      Text("الاكثر...",style: TextStyle(
          fontSize: 30,fontWeight: FontWeight.bold
      ),),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 180,
        child: ListView.builder(
            scrollDirection:Axis.horizontal,
            itemCount: images.length,
            itemBuilder:(context,index)=>GestureDetector(
              onTap: (){
                setState(() {
                  // images=index;
                });
              },
              child: Container(width:137,decoration: BoxDecoration(
                  color: Color(0xFFF8F8F7),
                  //   boxShadow: [
                  //     BoxShadow(
                  //         color: Colors.grey.withOpacity(0.5),
                  //         spreadRadius:2,
                  //         offset:Offset(2, 2),
                  //         blurRadius: 4
                  //     )
                  //   ],
                  // color: Colors.white,
                  //  border: Border.all(
                  //    color: Colors.grey,
                  //  ),

                  // 0xFFC2CCF6),

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
                                image:AssetImage( images[index])
                            )
                        ),
                        // child:Image.asset( images[index],height: 140,width: 140,)


                      ),
                    ),
                    Text("title",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
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
            ) ),
      ),
      Text("الاكثر...",style: TextStyle(
          fontSize: 30,fontWeight: FontWeight.bold)),
      // Container(
      //   margin: EdgeInsets.symmetric(horizontal: 20 /2),
      //   height: 160,
      //   child: ListView.builder(
      //       scrollDirection:Axis.horizontal,
      //       itemCount: images.length,
      //       itemBuilder:(context,index)=>GestureDetector(
      //         onTap: (){
      //           setState(() {
      //             // images=index;
      //           });
      //         },
      //         child: Container(
      //           alignment: Alignment.center,
      //           margin:EdgeInsets.only(left:20,
      //             // right: index==images.length -1 ?20:0),
      //           ),
      //           padding: EdgeInsets.symmetric(horizontal: 20),
      //           decoration: BoxDecoration(
      //             // color: index==selectedIndex?Colors.white.withOpacity(0.4):Color(0xFFC68FCE),
      //             borderRadius: BorderRadius.circular(6),
      //           ),
      //           child:Image.asset( images[index],height: 135,width: 120,)
      //           ,
      //
      //         ),
      //       ) ),
      // ),


      // Container(
      //   margin: EdgeInsets.symmetric(horizontal: 15),
      //   height: 180,
      //   child: ListView.builder(
      //       scrollDirection:Axis.horizontal,
      //       itemCount: images.length,
      //       itemBuilder:(context,index)=>GestureDetector(
      //         onTap: (){
      //           setState(() {
      //             // images=index;
      //           });
      //         },
      //         child: Container(width:125,decoration: BoxDecoration(
      //           //  color: Color(0xFFBBBABA),
      //           color: Color(0xFFBF9DC4),
      //            // 0xFFC2CCF6),
      //
      //             borderRadius: BorderRadius.circular(8)
      //         ), height: 180,margin: EdgeInsets.only(left: 10,right: 15),
      //           child: Column(crossAxisAlignment: CrossAxisAlignment.center,
      //             //mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 18.0,top: 2.8),
      //                 child: Container(
      //                   height: 130,
      //                   width: 120,
      //                   alignment: Alignment.center,
      //                   margin:EdgeInsets.only(left:20,
      //                     // right: index==images.length -1 ?20:0),
      //                   ),
      //                   // padding: EdgeInsets.symmetric(horizontal: 20),
      //                   decoration: BoxDecoration(color: Colors.black,
      //                       // color: index==selectedIndex?Colors.white.withOpacity(0.4):Color(0xFFC68FCE),
      //                       borderRadius: BorderRadius.circular(6),
      //                       image: DecorationImage(
      //                           fit: BoxFit.cover,
      //                           image:AssetImage( images[index])
      //                       )
      //                   ),
      //                   // child:Image.asset( images[index],height: 140,width: 140,)
      //
      //
      //                 ),
      //               ),
      //               Text("title",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
      //               Row(children: [
      //                 Row(children: [
      //                   Icon(Icons.auto_fix_high,color: Color(0xFF5743BB),size: 20,),
      //                   Text("Author",style: TextStyle(color: Colors.grey),)
      //                 ],),
      //                 Spacer(),
      //
      //                 Row(children: [
      //                   Text("pdf",style: TextStyle(color: Colors.grey),),
      //                   Icon(Icons.picture_as_pdf,color: Color(0xFF5743BB),size: 20,),
      //                 ],)
      //               ],)
      //             ],
      //           ),
      //         ),
      //       ) ),
      // ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 180,
        child: ListView.builder(
            scrollDirection:Axis.horizontal,
            itemCount: images.length,
            itemBuilder:(context,index)=>GestureDetector(
              onTap: (){
                setState(() {
                  // images=index;
                });
              },
              child: Container(width:125,decoration: BoxDecoration(
                  color: Color(0xFFFAFAF6),

                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.grey.withOpacity(0.5),
                  //       spreadRadius:2,
                  //       offset:Offset(2, 2),
                  //       blurRadius: 4
                  //   )
                  // ],
                  // border: Border.all(
                  //   color: Colors.grey,
                  // ),

                  // 0xFFC2CCF6),

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
                                image:AssetImage( images[index])
                            )
                        ),
                        // child:Image.asset( images[index],height: 140,width: 140,)


                      ),
                    ),
                    Text("title",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
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
            ) ),
      ),
    ],);
  }
}



