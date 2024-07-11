
/*
import 'package:flutter/material.dart';

class dProvider extends ChangeNotifier {


  String language = "en";
  void setLanguage(String ln) {
    language = ln;

    notifyListeners();
  }
}

*/







import 'package:flutter/material.dart';
import '../shared/shared.dart';

class dProvider extends ChangeNotifier {
  String _language = "en";

  String get language => _language;

  void setLanguage(String ln) {
    _language = ln;
    CacheNetwork.insertToCache(key: 'language', value: ln);
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    String? savedLanguage = await CacheNetwork.getCacheData(key: 'language');
    if (savedLanguage != null) {
      _language = savedLanguage;
      notifyListeners();
    }
  }
}

