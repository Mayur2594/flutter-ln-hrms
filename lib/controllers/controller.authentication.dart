import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/models/model.authentication.dart';
import 'package:ln_hrms/main.dart';
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:ln_hrms/services/service.authentication.dart';

class AuthenticationController extends GetxController {
  var userAuthForm = AthenticationModel(username: '', password: '');

  // ignore: non_constant_identifier_names
  final CommonController CommonCtrl = Get.put(CommonController());

  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var obscureText = true.obs;
  var data = {}.obs;
  void toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  authenticateUser(context) async {
    var userDetails = {
      "mobile": usernameController.value.text,
      "password": passwordController.value.text,
    };
    var result =
        await AuthenticationService().authenticateEmployee(userDetails);
    data(result);
    // ignore: collection_methods_unrelated_type
    if (data['success'] == true) {
      await CommonCtrl.saveDetailsInSharedPref("token", data['token']);
      await CommonCtrl.saveDetailsInSharedPref("userDetails", {
        "rolename": data["rolename"],
        "designationname": data["designationname"],
        "allow_bg_location": data["allow_bg_location"],
        "name": data["name"],
        "_id": data["_id"]
      });
      Get.to(MainScreen());
    } else {
      // return {"success": data["success"], "message": data["message"]};
      final snackBar = SnackBar(
          content: Text(
        "${data['message']}",
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
