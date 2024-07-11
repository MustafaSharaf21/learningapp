

import 'package:flutter/material.dart';
import 'package:learningapp/generated/l10n.dart';
import '../data/models/doc/doc.dart';

class documentation extends StatefulWidget {
   documentation(this. data,  {Key? key}) : super(key: key);
   List<Docu> data;
  @override
  State<documentation> createState() => _CourcesState();
}

class _CourcesState extends State<documentation> {

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
        itemCount: widget.data.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: const EdgeInsets.only(top: 0,left: 20,right: 20,bottom: 20),
              child: Container(height: 100,
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(17) )
                ,child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 55),
                              child: Text(widget.data[index].name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),)),
                            const SizedBox(height: 5,),
                            Text(S.of(context).here_we_will_put_description,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12),),
                            const Spacer(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // SizedBox( height:20,width:20,child: ImageIcon(AssetImage("assets/images/vedio.jpg",))),
                                  Text(S.of(context).author),
                                SizedBox(width: MediaQuery.of(context).size.width*0.30,),

                                // Icon(Icons.play_circle_outlined)
                              ],
                            )
                          ],
                        ),
                      ),
                      const Spacer(flex: 15,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: SizedBox(height: 200,
                          // width: 50,
                          child: Image.asset('assets/images/pdf.jpg',height: 50,width: 50,
                          ),),
                      )
                    ],
                  ),
                ),
              ),
            ),
      );
  }
   }
