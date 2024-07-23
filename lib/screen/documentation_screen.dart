import 'package:flutter/material.dart';
import '../data/models/doc/doc.dart';
import 'PdfViewerPage.dart';

class documentation extends StatefulWidget {
  final List<Docu> data;

  documentation(this.data, {Key? key}) : super(key: key);

  @override
  State<documentation> createState() => _DocumentationState();
}

class _DocumentationState extends State<documentation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DocumentViewer(
                  documentUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',  // استخدم الرابط الصالح هنا
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 55),
                            child: Text(
                              widget.data[index].name,
                              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'here we will put description',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("author"),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.30),
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(flex: 15),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 200,
                        child: Image.asset(
                          'assets/images/pdf.jpg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
