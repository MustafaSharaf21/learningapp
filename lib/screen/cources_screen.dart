import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/data/models/course/cources.dart';

import 'add_courses_page/add_courses_page.dart';

class Cources extends StatefulWidget {
  Cources(this.data, {Key? key}) : super(key: key);
  List<dynamic> data;
  @override
  State<Cources> createState() => _CourcesState();
}

class _CourcesState extends State<Cources> {
  List images = [
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
    "assets/images/pdf.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCoursesPage(),
            ),
          );
        },
        label: Text('Add course'),
        icon: Icon(Icons.add),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.data.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print("the id id id ${widget.data[index]['id']}");
            //context.go Video2(widget.data[index].id)
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(17)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 55),
                              child: Text(
                                widget.data[index]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.data[index]['description'],
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.lock_clock_outlined,
                                size: 20,
                                color: Color(0xffEC7D7F),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                              ),
                              Text("author")
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          height: 190,
                          width: 90,
                          child: Image.network(
                              "$urlIMG${widget.data[index]['image']}")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String urlIMG = 'http://192.168.1.6:8000';
