import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:learningapp/data/models/course/cources.dart';

import 'content_courses_spes.dart';

class Cources extends StatefulWidget {
  Cources(this.data, {Key? key}) : super(key: key);
  List<Datum> data;

  @override
  State<Cources> createState() => _CourcesState();
}

class _CourcesState extends State<Cources> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.data.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print("the id id id ${widget.data[index].id}");
          //context.go Video2(widget.data[index].id)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContentCoursesSpes( widget.data[index].id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 14,top: 8.0,right: 14),
          child: Container(
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data[index].name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.data[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
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
                            SizedBox(width: 8),
                            Text("author"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        widget.data[index].image != null ? 'http://192.168.43.63:8000' + widget.data[index].image : 'assets/images/creatTest3.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/creatTest3.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
