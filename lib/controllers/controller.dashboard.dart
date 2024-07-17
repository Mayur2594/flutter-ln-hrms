// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ln_hrms/helpers/helper.config.dart';
import 'package:ln_hrms/services/service.dashboard.dart';

class DashboardController extends GetxController {
  // ignore: non_constant_identifier_names
  final CommonController CommonCtrl = Get.put(CommonController());

  var userDetails = {}.obs;
  var dashbordDetails = <dynamic>[].obs;
  var topThreeEmployeesReview = <dynamic>[].obs;

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
      getTopThreeEmployeesReview();
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

  getTopThreeEmployeesReview() async {
    try {
      var result = await DashboardService().getTopThreeEmployeesReview();
      topThreeEmployeesReview(json.decode(result));
      print(topThreeEmployeesReview);
    } catch (ex) {
      print("Exception in controller dasboard getTopThreeEmployeesReview: $ex");
    }
  }

  getTopThreeEmployeesReviewWidget() {
    if (topThreeEmployeesReview.length > 0) {
      return CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            height: 100,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: topThreeEmployeesReview.map((item) {
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
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Image.network(
                                "${Config.baseUrl}/${item["profilepic"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item['employee_name'] ?? ""}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  Text(
                                    "${item['review'].toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }).toList());
    } else {
      return Text("No Record Available");
    }
  }
}
