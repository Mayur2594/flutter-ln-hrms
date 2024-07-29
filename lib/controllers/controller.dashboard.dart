// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ln_hrms/helpers/helper.config.dart';
import 'package:ln_hrms/services/service.dashboard.dart';
import 'package:ln_hrms/services/service.common.dart';
import 'package:ln_hrms/services/service.authentication.dart';

abstract class IChartData {
  String get category;
  double get value;
}

// models/chart_data.dart
class ChartData implements IChartData {
  ChartData(this.category, this.value, this.color);
  @override
  final String category;
  @override
  final double value;
  final Color color;
}

// ignore: deprecated_member_use
class DashboardController extends GetxController
    with SingleGetTickerProviderMixin {
  // ignore: non_constant_identifier_names
  final CommonController CommonCtrl = Get.put(CommonController());

  var isLoading = true.obs;
  var userDetails = {}.obs;
  var dashbordDetails = <dynamic>[].obs;
  var topThreeEmployeesReview = <dynamic>[].obs;
  var birthdaysInCurrentWeek = <dynamic>[].obs;
  var internetStatus = {}.obs;
  var attendanceStatus = {}.obs;
  var locationServiceMessage = ''.obs;
  var locationServiceStatus = false.obs;
  var topEmployeeWidget = Rx<Widget>(Container());
  var EmployeeBirthdaysWidget = Rx<Widget>(Container());
  late AnimationController animationController;
  var isProcesing = false.obs;
  var punchingInpregress = false.obs;
  @override
  void onInit() {
    getLocalStorageDetails();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  Future<void> refreshView() async {
    getDashboardDetails(userDetails['_id']);
  }

  var counter = 0;
  void simulateProcess() async {
    isProcesing.value = true;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    // Simulate a process with a delay

    await Future.delayed(const Duration(seconds: 2));
    checkInternetStatus();
    getCurrentPosition();
    if (isProcesing.value == false) animationController.stop();
  }

  List<ChartData> chartData = [];

  getLocalStorageDetails() async {
    try {
      counter = 0;
      isLoading.value = true;
      var savedDetails =
          await CommonCtrl.getDetailsFromSharedPref("userDetails");
      userDetails(json.decode(savedDetails.toString()));
      getDashboardDetails(userDetails['_id']);
      Future.delayed(const Duration(seconds: 2)).then((value) {
        isLoading.value = false;
      });
    } catch (ex) {
      print("Exception in getLocalStorageDetails: $ex");
      getDeviceUUID();
    }
  }

  var uuid = ''.obs;
  final _deviceUUID = DeviceUuid();

  Future<void> getDeviceUUID() async {
    try {
      uuid.value = await _deviceUUID.getUUID() ?? 'Unknown UUID';
      if (uuid.value.toString().trim().isNotEmpty &&
          uuid.value.toString().trim() != 'Unknown UUID') {
        authenticateUserWithUUID();
      }
    } catch (ex, StackTrace) {
      print("Exception in getting UUID: $ex");
      print("StackTrace in getting UUID: $StackTrace");
    }
  }

  var data = {}.obs;

  authenticateUserWithUUID() async {
    var userDetails = {"uuid": uuid.value};
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

      getLocalStorageDetails();
    } else {
      Get.toNamed('/');
    }
  }

  getDashboardDetails(userId) async {
    try {
      var result = await DashboardService()
          .getDashboardDetails({"userId": userId.toString()});
      var data = json.decode(result);

      if (data is List && data.length > 0) {
        dashbordDetails(data);
        chartData = [];
        chartData.add(ChartData(
            'Leaves',
            double.parse(dashbordDetails[0]['total_leaves'].toString()),
            const Color(0xFF7B2869)));
        chartData.add(ChartData(
            'Loan Amount',
            double.parse(dashbordDetails[0]['total_loan_amt'].toString()),
            const Color(0xFF9D3C72)));
        chartData.add(ChartData(
            'Loan Receipts',
            double.parse(dashbordDetails[0]['total_emi_paid'].toString()),
            const Color(0xFFC85C8E)));

        if (userDetails['allow_bg_location'] == 1) {
          if (dashbordDetails[0]["in_time"].toString().trim().isNotEmpty &&
              dashbordDetails[0]["in_time"].toString().trim() != "--:--") {
            if (dashbordDetails[0]["out_time"].toString().trim().isNotEmpty &&
                dashbordDetails[0]["out_time"].toString().trim() != "--:--") {
              commonService().stopBackgroundService();
            } else {
              commonService().initializeService();
            }
          }
        }
        getTopThreeEmployeesReview();
        getBirthdaysInCurrentWeek();
      } else {
        if (data['success'] == false) {
          getDeviceUUID();
        }
      }
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
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
      isLoading.value = false;
      return const Text("No Record Available");
    }
  }

  Future<void> checkInternetStatus() async {
    try {
      attendanceStatus.clear();
      var result = await DashboardService().checkInternetStatus();
      internetStatus(json.decode(result));
      internetStatus['dateTime'] = formatDate(internetStatus['dateTime']);
    } catch (ex) {
      print("Exception in controller dashboard checkInternetStatus: $ex");
    }
  }

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
    return formatter.format(dateTime.toLocal());
  }

  late bool serviceEnabled;
  late LocationPermission permission;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationServiceMessage.value =
          'Location services are disabled. Please enable the services';
      locationServiceStatus.value = false;
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationServiceMessage.value = 'Location permissions are denied';
        locationServiceStatus.value = false;
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      locationServiceMessage.value =
          'Location permissions are permanently denied, we cannot request permissions.';
      locationServiceStatus.value = false;
      return false;
    }
    return true;
  }

  String? currentAddress;
  Position? currentPosition;
  var markers = <Marker>[].obs;
  var circle = <Circle>[].obs;
  Future<void> getCurrentPosition() async {
    currentPosition = null;
    final hasPermission = await _handleLocationPermission();
    if (hasPermission == false) {
      return;
    } else {
      locationServiceStatus.value = true;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        currentPosition = position;
        markers.clear();
        circle.clear();
        markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: InfoWindow(
              title: 'Marker',
              snippet: 'Marker at ${position.latitude}, ${position.longitude}',
            ),
          ),
        );

        circle.add(
          Circle(
            circleId: CircleId(position.toString()),
            center: LatLng(position.latitude, position.longitude),
            fillColor: Color.fromARGB(61, 255, 82, 82),
            radius: 200,
            strokeColor: Color.fromARGB(174, 175, 48, 1),
            strokeWidth: 2,
            visible: true,
            zIndex: 12,
          ),
        );
        getAddressFromLatLng(position);
      }).catchError((e) {
        print("Error while getting Current Location: \n $e");
        currentAddress = "Something went wrong, Please tray again!";
        isProcesing.value = false;
      });
    }
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      isProcesing.value = false;
    }).catchError((e) {
      debugPrint(e);
      currentAddress = "Something went wrong, Please tray again!";
      isProcesing.value = false;
    });
  }

  Future<void> setAttendance(context) async {
    try {
      punchingInpregress.value = true;
      var attendanceDetails = {
        "address": currentAddress.toString(),
        "time": DateTime.now().toString(),
        "latitude": currentPosition!.latitude.toString(),
        "longitude": currentPosition!.longitude.toString()
      };
      var result = await DashboardService().setAttendance(attendanceDetails);
      attendanceStatus(json.decode(result));
      if (attendanceStatus.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 3));
        punchingInpregress.value = false;
        Navigator.pop(context, true);
      }
    } catch (ex) {
      print("Exception in controller dashboard setAttendance: $ex");
    }
  }
}
