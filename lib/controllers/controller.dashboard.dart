import 'dart:convert';
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/services/service.dashboard.dart';

class DashboardController extends GetxController {
  // ignore: non_constant_identifier_names
  final CommonController CommonCtrl = Get.put(CommonController());

  var userDetails = {}.obs;
  var dashbordDetails = <dynamic>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getLocalStorageDetails();
    super.onInit();
  }

  getLocalStorageDetails() async {
    try {
      var savedDetails =
          await CommonCtrl.getDetailsFromSharedPref("userDetails");
      userDetails(json.decode(savedDetails.toString()));
      print(userDetails);
      getDashboardDetails(userDetails['_id']);
    } catch (ex) {
      print("Exception in getLocalStorageDetails: ${ex}");
    }
  }

  getDashboardDetails(userId) async {
    try {
      var result = await DashboardService()
          .getDashboardDetails({"userId": userId.toString()});
      dashbordDetails(json.decode(result));
      print(dashbordDetails);
    } catch (ex) {
      print("Exception in controller dasboard getDashboardDetails: $ex");
    }
  }

  formatEmployeeId(empId) {
    if (empId.toString().trim().length > 4) {
      return "(${empId.toString().trim()})";
    }
    if (empId.toString().trim().length == 3) {
      return "(0${empId.toString().trim()})";
    }
    if (empId.toString().trim().length == 2) {
      return "(00${empId.toString().trim()})";
    }
    if (empId.toString().trim().length == 1) {
      return "(000${empId.toString().trim()})";
    }
    return empId;
  }
}
