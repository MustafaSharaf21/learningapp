import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart 'as http;
import '../const.dart';

String? token;
const String baseurl='http://192.168.118.128:8000/api/';
const String imgURL='http://192.168.118.128:8000';


class HttpHelper{

  static Future<Response> postData(

      {required String url, Map<String, dynamic>?body} )async{
    return await http.post(Uri.parse('$baseurl$url'),body: body,headers:{ 'Accept':'application/json',
      "Authorization":'Bearer ${box.read('token')}'});
  }
  static Future<Response> gettData({required String url})async {
    return await http.get(
        Uri.parse('$baseurl$url'), headers: {
      "Authorization": 'Bearer ${box.read('token')}'
    });
  }
  getData(String url)async {
    try {
      var response =await http.get(Uri.parse('$baseurl$url'));
      if (response.statusCode==200||response.statusCode==201){

        var responsebody=jsonDecode(response.body);
        return responsebody;
      }else{
        print('error ${response.statusCode}');

      }}
    catch (e){
      print('error catch $e');
    }
  }
}

////eline


