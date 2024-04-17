import 'package:flutter/material.dart';
import '../constants.dart';

InputDecoration buildInputDecoration(IconData icons,String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    labelText: hinttext,
    prefixIcon: Icon(icons,),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide:const  BorderSide(
          color:Kcolor,
          width: 1
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide:const  BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    enabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide:const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
  );
}


InputDecoration buildDecoration() {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide:const  BorderSide(
          color:Kcolor,
          width: 1
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide:const  BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    enabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide:const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
  );
}
