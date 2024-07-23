import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ln_hrms/helpers/helper.config.dart';
import 'package:ln_hrms/controllers/controller.common.dart';

class EmployeeService {
  // ignore: non_constant_identifier_names
  final CommonController CommonCtrl = Get.put(CommonController());

  Future officeContacts() async {
    var token = await CommonCtrl.getDetailsFromSharedPref("token");

    final response = await http
        .get(Uri.parse('${Config.baseUrl}/api/officeContacts'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return json.decode(
          "{'status': false, 'message': 'Somthing went wrong, Please try Again!'}");
    }
  }
}
