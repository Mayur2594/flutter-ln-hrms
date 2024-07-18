import 'package:get/get.dart';
import 'package:ln_hrms/controllers/controller.authentication.dart';
import 'package:ln_hrms/controllers/controller.dashboard.dart';
import 'package:ln_hrms/controllers/controller.contacts.dart';

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
