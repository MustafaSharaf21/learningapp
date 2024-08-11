import 'package:get/get.dart';

class UserRoleController extends GetxController {
  var roleId = 0.obs;
  var courseId = 0.obs;
  var userId = 0.obs;


  void setRoleId(int newRoleId) {
    print('Setting roleId to: $newRoleId');
    roleId.value = newRoleId;
  }

  void setcourseId(int newcourseId) {
    courseId.value = newcourseId;
  }
  void setuserId(int newuserId) {
    userId.value = newuserId;
  }
}