import 'dart:convert';
import 'package:get/get.dart';
import 'package:ln_hrms/controllers/controller.dashboard.dart';
import 'package:ln_hrms/services/service.employee.dart';

class AttendanceController extends GetxController {
  var attendanceList = <dynamic>[].obs;
  var filteredAttendanceList = <dynamic>[].obs;
  var loadingContacts = false.obs;
  var selectedMonth = 0.obs;
  var selectedYear = 0.obs;

  final _months = [
    {
      "text": 'January',
      "value": 'January',
    },
    {
      "text": 'February',
      "value": 'February',
    },
    {
      "text": 'March',
      "value": 'March',
    },
    {
      "text": 'April',
      "value": 'April',
    },
    {
      "text": 'May',
      "value": 'May',
    },
    {
      "text": 'June',
      "value": 'June',
    },
    {
      "text": 'July',
      "value": 'July',
    },
    {
      "text": 'August',
      "value": 'August',
    },
    {
      "text": 'September',
      "value": 'September',
    },
    {
      "text": 'October',
      "value": 'October',
    },
    {
      "text": 'November',
      "value": 'November',
    },
    {
      "text": 'December',
      "value": 'December',
    },
  ];

  final DashboardController DashboardCtrl = Get.put(DashboardController());
  @override
  void onInit() {
    DateTime now = DateTime.now();
    selectedYear.value = now.year;
    selectedMonth.value = now.month;
    selectedMonth.value =
        selectedMonth.value > 0 ? selectedMonth.value - 1 : selectedMonth.value;
    getEmployeesAttendanceList(selectedYear.value, selectedMonth.value);
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> refreshPage() async {
    onInit();
  }

  getEmployeesAttendanceList(selectedYr, selectedMonthindex) async {
    try {
      if (selectedYr.toString().trim().isNotEmpty && selectedMonthindex >= 0) {
        var selectedDate =
            "${_months[selectedMonthindex]["value"]!}-${selectedYr.toString().trim()}";
        loadingContacts.value = true;
        var result = await EmployeeService().getEmployeesAttendanceList({
          "employee_id": DashboardCtrl.userDetails['_id'].toString(),
          "date": selectedDate
        });
        print(json.decode(result));
        attendanceList(json.decode(result));
        filteredAttendanceList.value = attendanceList;
        loadingContacts.value = false;
      } else {}
    } catch (ex, stackTrace) {
      print(
          "Exception in controller attendance getEmployeesAttendanceList: $ex \n $stackTrace");
    }
  }

  void filterAttendance(String query) {
    if (query.isEmpty) {
      filteredAttendanceList.value = attendanceList;
    } else {
      filteredAttendanceList.value = attendanceList
          .where((contact) =>
              json.encode(contact).toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  DateTime getDateNTime(String date, String time) {
    // Split the date components
    List<String> dateComponents = date.split('-');
    int day = int.parse(dateComponents[0]);
    int month =
        int.parse(dateComponents[1]) - 1; // Months are zero-based in JavaScript
    int year = int.parse(dateComponents[2]);

    // Split the time components
    List<String> timeComponents = time.split(':');
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);

    // Create a DateTime object
    return DateTime(year, month, day, hours, minutes);
  }

  String getTimeDifference(Map<String, dynamic> obj) {
    DateTime timeStart = getDateNTime(obj['att_date']!, obj['min_intime']!);
    DateTime timeEnd = getDateNTime(obj['att_date']!, obj['in_time']!);

    Duration difference = timeEnd.difference(timeStart);
    int diffHrs = difference.inHours;
    int diffMins = difference.inMinutes.remainder(60);

    if (diffHrs > 0 || diffMins > 0) {
      return '$diffHrs:$diffMins';
    } else {
      return '';
    }
  }
}
