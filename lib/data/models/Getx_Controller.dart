import 'package:get/get.dart';

class UserRoleController extends GetxController {
  var roleId = 0.obs;
  var courseId = 0.obs;

  void setRoleId(int newRoleId) {
    roleId.value = newRoleId;
  }

  void setcourseId(int newcourseId) {
    courseId.value = newcourseId;
  }
}