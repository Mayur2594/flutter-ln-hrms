import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/models/model.authentication.dart';
import 'package:ln_hrms/main.dart';
import 'package:ln_hrms/services/service.authentication.dart';

class AuthenticationController extends GetxController {
  var userAuthForm = AthenticationModel(username: '', password: '');

  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var obscureText = true.obs;

  void toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  authenticateUser() async {
    var result = await AuthenticationService().authenticateEmployee({
      "mobile": usernameController.value,
      "password": passwordController.value,
    });
    // Get.to(MainScreen());
  }
}
