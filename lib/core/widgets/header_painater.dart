import 'package:flutter/material.dart';

import '../constants.dart';



class FullHeaderPainter extends StatefulWidget {
  String HeaderText;

  FullHeaderPainter({required this.HeaderText});

  @override
  State<FullHeaderPainter> createState() => _FullHeaderPainterState();
}

class _FullHeaderPainterState extends State<FullHeaderPainter> {
  /* FirebaseService _service= FirebaseService();*/
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
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
                child: Image.asset(
                  'assets/images/login_img.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],

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


/*
height: MediaQuery.sizeOf(context).height / 5 + 130,*/
