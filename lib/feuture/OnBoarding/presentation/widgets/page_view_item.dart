import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, this.image, this.title, this.subtitle});
final String? image;
final String? title;
final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:60),
          child: Image.asset(image!),
        ),
        Text(title!,style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
        Padding(
          padding: const EdgeInsets.only(top:8,
          left: 45,right: 35),
          child: Text(subtitle!,style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xff78787c)
          ),),
        ),
      ],
    );
  }
}
