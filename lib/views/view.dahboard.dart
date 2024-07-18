import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:ln_hrms/helpers/helper.config.dart";
import 'package:ln_hrms/controllers/controller.dashboard.dart';
import 'package:ln_hrms/customwidgets/widget.applayout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends StatelessWidget {
  // ignore: non_constant_identifier_names
  // final DashboardController DashboardCtrl = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final DashboardController DashboardCtrl = Get.find();
    return Scaffold(
      appBar: AppBarView(),
      drawer: DrawerView(),
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
                                              SizedBox(width: 5),
                                              Text(
                                                data.category,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              SizedBox(width: 5),
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
                                              SizedBox(width: 5),
                                              Text(
                                                data.category,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              SizedBox(width: 5),
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
                                                builder:
                                                    (BuildContext context) {
                                                  return FullScreenDialog();
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
                      return Column(
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
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const Expanded(
              child: const Center(
                child: const Text('This is a full screen dialog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
