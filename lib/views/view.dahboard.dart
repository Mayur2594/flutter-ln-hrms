import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:ln_hrms/helpers/helper.config.dart";
import 'package:ln_hrms/controllers/controller.dashboard.dart';
import 'package:ln_hrms/customwidgets/widget.applayout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  // ignore: non_constant_identifier_names
  // final DashboardController DashboardCtrl = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final DashboardController DashboardCtrl = Get.find();
    return Scaffold(
      appBar: AppBarView(),
      drawer: const DrawerView(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card.outlined(
              // margin: const EdgeInsets.all(5), // Edge-to-edge
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // Edge-to-edge
              ),
              elevation: 6,
              color: Colors.white,
              shadowColor: Colors.white,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Obx(() {
                  if (DashboardCtrl.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    if (DashboardCtrl.dashbordDetails.isNotEmpty &&
                        DashboardCtrl.chartData.isNotEmpty) {
                      var dsbDetails = DashboardCtrl.dashbordDetails[0];
                      return SizedBox(
                        child: Container(
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 12,
                                      child: Container(
                                        // padding: const EdgeInsets.all(8.0),
                                        // decoration: BoxDecoration(
                                        //   border: Border(
                                        //     right: BorderSide(
                                        //         color: Colors.grey.shade300),
                                        //   ),
                                        // ),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 75,
                                                backgroundImage: NetworkImage(
                                                    "${Config.baseUrl}/${dsbDetails["_profilepic"]}"),
                                              ),
                                              SfCircularChart(
                                                series: <CircularSeries>[
                                                  RadialBarSeries<ChartData,
                                                      String>(
                                                    dataSource:
                                                        DashboardCtrl.chartData,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.category,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.value,
                                                    pointColorMapper:
                                                        (ChartData data, _) =>
                                                            data.color,
                                                    maximumValue: 100,
                                                    innerRadius: '70%',
                                                    gap: '15%',
                                                    radius: '80%',
                                                  ),
                                                ],
                                              ),
                                            ]),
                                        // child: Image.network(
                                        //   "${Config.baseUrl}/${dsbDetails["_profilepic"]}",
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: DashboardCtrl.chartData
                                          .sublist(0, 1)
                                          .map((data) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: data.color,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                data.category,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                data.value.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: DashboardCtrl.chartData
                                          .sublist(1)
                                          .map((data) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: data.color,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                data.category,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                data.value.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        // decoration: BoxDecoration(
                                        //   border: Border(
                                        //     top: BorderSide(
                                        //         color: Colors.grey.shade300),
                                        //   ),
                                        // ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${DashboardCtrl.userDetails['name'] ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                            Text(
                                              "${DashboardCtrl.formatEmployeeId(DashboardCtrl.userDetails['_id'] ?? "")}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            ),
                                            Text(
                                              "${DashboardCtrl.userDetails['designationname'] ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            ),
                                            Text(
                                              'Shift: ${DashboardCtrl.dashbordDetails[0]["working_shift"] ?? ""}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            ),
                                            Text(
                                              'Manager: ${DashboardCtrl.dashbordDetails[0]["manager_name"] ?? "Not Assinged"}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              border: BorderDirectional(
                                                  start: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1))),
                                          child: MaterialButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return const FullScreenDialog();
                                                },
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'lib/assets/gif/fingerprint.gif',
                                                  fit: BoxFit.cover,
                                                ),
                                                Text('PUNCH',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 12,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: Column(
                                                  children: [
                                                    _buildDetailItem('In/Out',
                                                        '${DashboardCtrl.dashbordDetails[0]["in_time"] ?? ""}/${DashboardCtrl.dashbordDetails[0]["out_time"] ?? ""}'),
                                                    _buildDetailItem('Days',
                                                        '${DashboardCtrl.dashbordDetails[0]["prest_days_count"] ?? ""}/${DashboardCtrl.dashbordDetails[0]["no_days"] ?? ""}'),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Column(
                                                  children: [
                                                    _buildDetailItem(
                                                        'Last Punch',
                                                        DashboardCtrl.dashbordDetails[
                                                                    0][
                                                                "last_punch"] ??
                                                            ""),
                                                    _buildDetailItem(
                                                        'Salary',
                                                        DashboardCtrl.dashbordDetails[
                                                                    0][
                                                                "salary_date"] ??
                                                            ""),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Column(
                        children: [Text("No Records Found")],
                      );
                    }
                  }
                }),
              ),
            ),
            Card.outlined(
                margin: const EdgeInsets.all(5), // Edge-to-edge
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Edge-to-edge
                ),
                elevation: 6,
                color: Colors.white,
                shadowColor: Colors.white,
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Employee(s) of the month",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Obx(
                          () {
                            return Container(
                              child: DashboardCtrl.topEmployeeWidget.value,
                            );
                          },
                        )
                      ],
                    ))),
            Card.outlined(
                margin: const EdgeInsets.all(5), // Edge-to-edge
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Edge-to-edge
                ),
                elevation: 6,
                color: Colors.white,
                shadowColor: Colors.white,
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Birthday(s) in week",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Obx(
                          () {
                            return Container(
                              child:
                                  DashboardCtrl.EmployeeBirthdaysWidget.value,
                            );
                          },
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value ?? "", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class FullScreenDialog extends StatelessWidget {
  const FullScreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController DashboardCtrl = Get.find();
    DashboardCtrl.checkInternetStatus();
    DashboardCtrl.getCurrentPosition();
    return Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(0),
        child: Obx(
          () => Center(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // color: Colors.white,

            child: Column(
              children: [
                AppBar(
                  title: const Text("Mark Attendance"),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Date: ${DashboardCtrl.internetStatus['dateTime']}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Internet Status: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.check_circle,
                              color:
                                  DashboardCtrl.internetStatus['status'] == 200
                                      ? Colors.green
                                      : Colors.red,
                            ),
                            Text(
                              DashboardCtrl.internetStatus['status'] == 200
                                  ? "ON"
                                  : "OFF",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      DashboardCtrl.internetStatus['status'] ==
                                              200
                                          ? Colors.green
                                          : Colors.red),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Location Service Status: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: DashboardCtrl.locationServiceStatus == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            Text(
                              DashboardCtrl.locationServiceStatus == true
                                  ? "ON"
                                  : "OFF",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: DashboardCtrl.locationServiceStatus ==
                                          true
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                        const Divider(),
                        const Row(
                          children: [
                            Text(
                              "Address:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(children: [
                          Expanded(
                              flex: 12,
                              child: Text("${DashboardCtrl.currentAddress}")),
                        ]),
                        const Divider(),
                        Container(
                          height: 250,
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: DashboardCtrl.currentPosition != null
                              ? GoogleMap(
                                  mapType: MapType.terrain,
                                  markers: DashboardCtrl.markers.toSet(),
                                  circles: DashboardCtrl.circle.toSet(),
                                  initialCameraPosition: CameraPosition(
                                      zoom: 16,
                                      target: LatLng(
                                          DashboardCtrl
                                              .currentPosition!.latitude,
                                          DashboardCtrl
                                              .currentPosition!.longitude)))
                              : const Text("Something went wrong!"),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: MaterialButton(
                                onPressed: () {
                                  DashboardCtrl.simulateProcess();
                                },
                                child: Row(
                                  children: [
                                    const Text(
                                      "Retry ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFA000),
                                          fontSize: 18),
                                    ),
                                    DashboardCtrl.isProcesing.value == true
                                        ? AnimatedBuilder(
                                            builder: (context, child) {
                                              return Transform.rotate(
                                                angle: DashboardCtrl
                                                        .animationController
                                                        .value *
                                                    2.0 *
                                                    3.14159, // Rotate continuously
                                                child: child,
                                              );
                                            },
                                            animation: DashboardCtrl
                                                .animationController,
                                            child: const Icon(
                                              Icons.refresh,
                                              color: Color(0xFFFFA000),
                                            ),
                                          )
                                        : const Icon(
                                            Icons.refresh,
                                            color: Color(0xFFFFA000),
                                          )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: DashboardCtrl.attendanceStatus != null
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 10,
                                        child: Text(
                                          "${DashboardCtrl.attendanceStatus['message']}",
                                        ))
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(colors: [
                          Color(0xFF654ea3),
                          Color(0xFFeaafc8),
                        ]),
                      ),
                      child: MaterialButton(
                        elevation: 6,
                        onPressed: () {
                          DashboardCtrl.setAttendance();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 6.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: Color.fromARGB(235, 255, 255, 255),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
