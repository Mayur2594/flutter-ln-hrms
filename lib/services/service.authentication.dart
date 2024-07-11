import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationService {
  static const String baseUrl = 'https://threesainfoway.net:8896';

  // ignore: non_constant_identifier_names
  Future<Map<String, dynamic>> authenticateEmployee(var EmployeeDetails) async {
    print(EmployeeDetails);
    final response = await http.post(
        Uri.parse('$baseUrl/api/authenticateEmployee'),
        body: EmployeeDetails);
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
