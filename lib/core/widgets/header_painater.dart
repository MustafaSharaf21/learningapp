import 'dart:io';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:image_picker/image_picker.dart';


class FullHeaderPainter extends StatefulWidget {
  String HeaderText;
  FullHeaderPainter({required this.HeaderText});


  @override
  State<FullHeaderPainter> createState() => _FullHeaderPainterState();
}

class _FullHeaderPainterState extends State<FullHeaderPainter> {
   File?image;
  final _pickedFile = ImagePicker();
  showOption(BuildContext context){
    return showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title:const  Text("make a choice"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading:const  Icon(Icons.image),
                      title:const  Text("Gallery"),
                      onTap:()=> _imageFromGallery(context),
                    ),
                    ListTile(
                      leading:const  Icon(Icons.camera_alt_outlined),
                      title:const  Text("Camera"),
                      onTap:()=> _imageFromCamera(context),
                    ),
                  ],
                ),
              ),
            )
    );

  }
  Future _imageFromGallery(BuildContext context)async{
   var pickedImage=await _pickedFile.pickImage(source:ImageSource.gallery);
   if(pickedImage!=null){
     setState(() {
       image =File(pickedImage.path);
     });
   }else{}
   Navigator.pop(context);
  }
  Future _imageFromCamera(BuildContext context)async{
    var pickedImage=await _pickedFile.pickImage(source:ImageSource.camera);
    if(pickedImage!=null){
      setState(() {
        image =File(pickedImage.path);
      });
    }else{}
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
    children: [
      Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: HeaderPainter(),
          child: SizedBox(
            width: size.width,
            height: size.height / 5,
            child: Center(
              child: Text(
                widget.HeaderText,
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -110,
          child: Row(
            children: [
                Container(
                  width: 130,
                  height: 130,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(1000)),
                  child: image==null?Image.asset('assets/images/login_img.png',
                    fit: BoxFit.cover,):Image.file(image!,fit: BoxFit.cover,),

                ),

              ],

          ),
        ),
      ],
      ),
      Container(
        margin:const  EdgeInsets.only(left: 115,top: 80),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          color:Kcolor,
        ),
        child:GestureDetector(
          onTap: (){
            print("mustafa sharaf");
            showOption(context);
          },
          child:const Icon(
            Icons.camera_alt_outlined,
            size: 15,
          ),
        ),
      ),
    ]

    );
  }
}





class FullHeader extends StatefulWidget {
  String HeaderText;
   FullHeader({required this.HeaderText});

  @override
  State<FullHeader> createState() => _FullHeaderState();
}

class _FullHeaderState extends State<FullHeader> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                painter: HeaderPainter(),
                child: SizedBox(
                  width: size.width,
                  height: size.height / 5,
                  child: Center(
                    child: Text(
                      widget.HeaderText,
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -110,
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      clipBehavior: Clip.antiAlias,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(1000)),
                      child: Image.asset('assets/images/login_img.png',
                        fit: BoxFit.cover,
                      ),

                    ),

                  ],

                ),
              ),
            ],
          ),
        ]

    );
  }
}








class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color =  Kcolor;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height-20);
    path.quadraticBezierTo(
        size.width /6, size.height + 140, size.width, size.height-30);
    path.lineTo(size.width, 0);
    path.close();
    return canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



