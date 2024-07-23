import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ln_hrms/helpers/helper.config.dart';

class AuthenticationService {
  // ignore: non_constant_identifier_names
  Future<Map<String, dynamic>> authenticateEmployee(var EmployeeDetails) async {
    final response = await http.post(
        Uri.parse('${Config.baseUrl}/api/authenticateEmployee'),
        body: EmployeeDetails);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> authenticateUserWithUUID(
      var EmployeeDetails) async {
    final response = await http.post(
        Uri.parse('${Config.baseUrl}/api/authenticateEmployeeUuid'),
        body: EmployeeDetails);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
