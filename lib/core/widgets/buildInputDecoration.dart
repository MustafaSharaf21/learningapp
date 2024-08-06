
import 'package:flutter/material.dart';
import '../constants.dart';

InputDecoration buildInputDecoration(BuildContext context, IconData icons, String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    labelText: hinttext,
    prefixIcon: Icon(icons, color: Theme.of(context).iconTheme.color),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Kcolor,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
  );
}

InputDecoration buildDecoration(BuildContext context, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Theme.of(context).iconTheme.color), // تعيين لون الأيقونات بناءً على المظهر الحالي
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Kcolor,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
  );
}