import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cources extends StatefulWidget {
  const Cources({Key? key}) : super(key: key);

  @override
  State<Cources> createState() => _CourcesState();
}

class _CourcesState extends State<Cources> {

  List images =[
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: const EdgeInsets.only(top: 0,left: 20,right: 20,bottom: 20),
              child: Container(height: 130,
                decoration: BoxDecoration(border:Border.all(color: Colors.black12),borderRadius: BorderRadius.circular(17) )
                ,child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 55),child: Text('Title',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),)),
                            SizedBox(height: 5,),
                            Text('here we will put description',style: TextStyle(color: Colors.grey[600],fontSize: 12),),
                            Spacer(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.lock_clock_outlined,size: 20,color: Color(0xffEC7D7F),),
                                SizedBox(width: MediaQuery.of(context).size.width*0.30,),
                                Text("author")
                              ],
                            )
                          ],
                        ),
                      ),
                      Spacer(flex: 15,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Container(height: 190,
                            width: 90,
                            child: Image.asset("assets/2.jpg")),
                      )
                    ],
                  ),
                ),
              ),
            ),
      );
  }}