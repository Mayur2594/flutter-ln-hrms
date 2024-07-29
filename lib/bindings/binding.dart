import 'package:get/get.dart';
import 'package:ln_hrms/controllers/controller.authentication.dart';
import 'package:ln_hrms/controllers/controller.dashboard.dart';
import 'package:ln_hrms/controllers/controller.contacts.dart';
import 'package:ln_hrms/controllers/controller.attendance.dart';
import 'package:ln_hrms/controllers/controller.employee.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
  }
}

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactsController>(() => ContactsController());
  }
}

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceController>(() => AttendanceController());
  }
}

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
  }
}
