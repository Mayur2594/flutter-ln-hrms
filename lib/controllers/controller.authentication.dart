// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ln_hrms/customwidgets/widget.applayout.dart';
import 'package:ln_hrms/helpers/helper.config.dart';
import 'package:ln_hrms/models/model.authentication.dart';
import 'package:ln_hrms/views/view.dahboard.dart';
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:ln_hrms/services/service.authentication.dart';

class AuthenticationController extends GetxController {
  var userAuthForm = AthenticationModel(username: '', password: '');

  var uuid = ''.obs;
  final _deviceUUID = DeviceUuid();
  @override
  void onInit() {
    // TODO: implement onInit
    getDeviceUUID();
    super.onInit();
  }

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

  Future<void> getDeviceUUID() async {
    try {
      uuid.value = await _deviceUUID.getUUID() ?? 'Unknown UUID';
      print("uuid: ${uuid.value}");
      if (uuid.value.toString().trim().length > 0 &&
          uuid.value.toString().trim() != 'Unknown UUID') {
        authenticateUserWithUUID();
      }
    } catch (ex, StackTrace) {
      print("Exception in getting UUID: $ex");
      print("StackTrace in getting UUID: $StackTrace");
    }
  }

  authenticateUser(context) async {
    var userDetails = {
      "mobile": usernameController.value.text,
      "password": passwordController.value.text,
      "uuid": uuid.value.toString()
    };
    print(userDetails);
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
      Get.to(DashboardView());
    } else {
      // return {"success": data["success"], "message": data["message"]};
      final snackBar = SnackBar(
          content: Text(
        "${data['message']}",
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  authenticateUserWithUUID() async {
    var userDetails = {"uuid": uuid.value};
    print("userDetails: $userDetails");
    var result =
        await AuthenticationService().authenticateUserWithUUID(userDetails);
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

      Get.to(DashboardView());
    } else {
      print(data);
    }
  }
}
