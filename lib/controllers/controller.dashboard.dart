// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ln_hrms/helpers/helper.config.dart';
import 'package:ln_hrms/services/service.dashboard.dart';

abstract class IChartData {
  String get category;
  double get value;
}

// models/chart_data.dart
class ChartData implements IChartData {
  ChartData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}

class DashboardController extends GetxController {
  // ignore: non_constant_identifier_names
  final CommonController CommonCtrl = Get.put(CommonController());

  var isLoading = true.obs;
  var userDetails = {}.obs;
  var dashbordDetails = <dynamic>[].obs;
  var topThreeEmployeesReview = <dynamic>[].obs;
  var birthdaysInCurrentWeek = <dynamic>[].obs;
  var topEmployeeWidget = Rx<Widget>(Container());
  var EmployeeBirthdaysWidget = Rx<Widget>(Container());

  @override
  void onInit() {
    // TODO: implement onInit
    getLocalStorageDetails();
    super.onInit();
  }

  List<ChartData> chartData = [];

  getLocalStorageDetails() async {
    try {
      var savedDetails =
          await CommonCtrl.getDetailsFromSharedPref("userDetails");
      userDetails(json.decode(savedDetails.toString()));
      getDashboardDetails(userDetails['_id']);
      getTopThreeEmployeesReview();
      getBirthdaysInCurrentWeek();
    } catch (ex) {
      print("Exception in getLocalStorageDetails: ${ex}");
    } finally {
      isLoading.value = false;
    }
  }

  getDashboardDetails(userId) async {
    try {
      var result = await DashboardService()
          .getDashboardDetails({"userId": userId.toString()});
      dashbordDetails(json.decode(result));

      chartData = [];
      chartData.add(ChartData(
          'Leaves',
          double.parse(dashbordDetails[0]['total_leaves'].toString()),
          Color(0xFF7B2869)));
      chartData.add(ChartData(
          'Loan Amount',
          double.parse(dashbordDetails[0]['total_loan_amt'].toString()),
          Color(0xFF9D3C72)));
      chartData.add(ChartData(
          'Loan Receipts',
          double.parse(dashbordDetails[0]['total_emi_paid'].toString()),
          Color(0xFFC85C8E)));
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

  Future<void> getTopThreeEmployeesReview() async {
    try {
      var result = await DashboardService().getTopThreeEmployeesReview();
      topThreeEmployeesReview.value = json.decode(result);
      topEmployeeWidget.value =
          getTopThreeEmployeesReviewWidget(topThreeEmployeesReview);
    } catch (ex) {
      print(
          "Exception in controller dashboard getTopThreeEmployeesReview: $ex");
    }
  }

  Widget getTopThreeEmployeesReviewWidget(List<dynamic> reviews) {
    if (reviews.isNotEmpty) {
      return CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 100,
          autoPlay: true,
          aspectRatio: 6 / 4,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: reviews.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            alignment: Alignment.center,
                            height: 75,
                            child: Image.network(
                              "${Config.baseUrl}/${item["profilepic"]}",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item['employee_name'] ?? ""}",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Color.fromARGB(237, 255, 213, 0),
                                    ),
                                    Text(
                                      item['review'].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      );
    } else {
      return const Text("No Record Available");
    }
  }

  Future<void> getBirthdaysInCurrentWeek() async {
    try {
      var result = await DashboardService().getBirthdaysInCurrentWeek();
      birthdaysInCurrentWeek.value = json.decode(result);
      EmployeeBirthdaysWidget.value =
          getEmployeesBirthdayWidget(birthdaysInCurrentWeek.value);
    } catch (ex) {
      print("Exception in controller dashboard getBirthdaysInCurrentWeek: $ex");
    }
  }

  Widget getEmployeesBirthdayWidget(List<dynamic> birthdays) {
    if (birthdays.isNotEmpty) {
      return CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 100,
          autoPlay: true,
          aspectRatio: 6 / 4,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: birthdays.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            alignment: Alignment.center,
                            height: 75,
                            child: Image.network(
                              "${Config.baseUrl}/${item["_profilepic"]}",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${item['first_name'] ?? ""}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${item['last_name'] ?? ""}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${item['_dob'] ?? ""}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      );
    } else {
      return const Text("No Record Available");
    }
  }
}
