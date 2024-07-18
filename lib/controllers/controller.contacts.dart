import 'dart:convert';
import 'package:get/get.dart';
import 'package:ln_hrms/services/service.employee.dart';

class ContactsController extends GetxController {
  var contactsList = <dynamic>[].obs;
  var filteredContactsList = <dynamic>[].obs;
  @override
  void onInit() {
    officeContacts();
    // TODO: implement onInit
    super.onInit();
  }

  officeContacts() async {
    try {
      var result = await EmployeeService().officeContacts();
      contactsList(json.decode(result));
      filteredContactsList.value = contactsList;
    } catch (ex) {
      print("Exception in controller dasboard officeContacts: $ex");
    }
  }

  void filterContacts(String query) {
    if (query.isEmpty) {
      filteredContactsList.value = contactsList;
    } else {
      filteredContactsList.value = contactsList
          .where((contact) =>
              json.encode(contact).toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
