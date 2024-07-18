import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ln_hrms/helpers/helper.config.dart';
import 'package:ln_hrms/controllers/controller.common.dart';

class DashboardService {
  // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  final CommonController CommonCtrl = Get.put(CommonController());

  Future getDashboardDetails(var userDetails) async {
    var _token = await CommonCtrl.getDetailsFromSharedPref("token");

    final response =
        await http.post(Uri.parse('${Config.baseUrl}/api/getDashboardDetails'),
            headers: {
              'Authorization': 'Bearer $_token',
            },
            body: userDetails);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return json.decode(
          "{'status': false, 'message': 'Somthing went wrong, Please try Again!'}");
    }
  }

  Future getTopThreeEmployeesReview() async {
    var _token = await CommonCtrl.getDetailsFromSharedPref("token");

    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/getTopThreeEmployeesReview'),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return json.decode(
          "{'status': false, 'message': 'Somthing went wrong, Please try Again!'}");
    }
  }

  Future getBirthdaysInCurrentWeek() async {
    var _token = await CommonCtrl.getDetailsFromSharedPref("token");

    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/getBirthdaysInCurrentWeek'),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return json.decode(
          "{'status': false, 'message': 'Somthing went wrong, Please try Again!'}");
    }
  }
}
