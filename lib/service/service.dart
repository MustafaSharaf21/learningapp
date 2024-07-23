

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../feuture/OnBoarding/presentation/on_boarding_view.dart';
import '../screen/edit_content_page/edit_content_page.dart';
import '../screen/login_screen.dart';

class PageService {
  // final _box = ;
  GetStorage _box = GetStorage();
  final _key = 'boarding';
  _saveData(bool complete) => _box.write(_key, complete);
  bool _readFromBox() => _box.read(_key) ?? false;
  Widget startPage() {
    return _readFromBox()
        ? _box.read('token') == null
        ? LoginPage()
        : HomePage()
        : const OnBoardingView();
  }

  submit( context ) {
    _saveData(!_readFromBox());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
          (route) => false,
    );
  }

  /*submit( context ) {
    _saveData(!_readFromBox());
    Navigator.pushNamedAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder:(context)=>LoginPage()
        ) ,
            (route)=>false
    );

  }*/
}


