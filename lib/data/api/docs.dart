import 'dart:convert';

import 'package:http/http.dart' as http;

import '../http.dart';
import '../models/doc/doc.dart';
class docs{
 static  Future<Docs> getAllDocs ()async{
    var response =  await http.get(Uri.parse('uri'),
    headers:{"Authorization":"Bearer $token"}
 );
    if(response.statusCode==200)
    {

      return Docs.fromJson(json.decode(response.body));
    }
    else{
      return new Docs(data: [], status: '');
    }
}
}