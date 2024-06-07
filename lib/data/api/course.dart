
import 'dart:convert';

import 'package:http/http.dart'as http;

import '../http.dart';
import '../models/course/cources.dart';

class CourseApi{

static  Future<Course>getAllCourse()async
  {
    var response=await http.get(Uri.parse('uri'),
    headers: {
      "Authorization":"Bearer $token"
    },
    );
    if(response.statusCode==200)
      {

        return Course.fromJson(json.decode(response.body));
      }
    else{
      return new Course(data: [], status: '');
    }
  }

}
