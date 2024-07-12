import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import "package:ln_hrms/helpers/helper.config.dart";
import 'package:ln_hrms/controllers/controller.dashboard.dart';

class DashboardView extends StatelessWidget {
  final DashboardController DashboardCtrl = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card.outlined(
            margin: const EdgeInsets.all(5), // Edge-to-edge
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Edge-to-edge
            ),
            elevation: 6,
            shadowColor: Colors.grey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Obx(() {
                if (DashboardCtrl.dashbordDetails.isNotEmpty) {
                  var dsbDetails = DashboardCtrl.dashbordDetails[0];
                  return SizedBox(
                    child: Container(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                    child: Image.network(
                                      "${Config.baseUrl}/${dsbDetails["_profilepic"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                        Text(
                                          "${DashboardCtrl.userDetails['designationname'] ?? ""}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                        Text(
                                          'Shift: ${DashboardCtrl.dashbordDetails[0]["working_shift"] ?? ""}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                        Text(
                                          'Manager: ${DashboardCtrl.dashbordDetails[0]["manager_name"] ?? "Not Assinged"}',
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
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              children: [
                                                _buildDetailItem(
                                                    'Salary',
                                                    DashboardCtrl
                                                                .dashbordDetails[
                                                            0]["salary_date"] ??
                                                        ""),
                                                _buildDetailItem('In/Out',
                                                    '${DashboardCtrl.dashbordDetails[0]["in_time"] ?? ""}/${DashboardCtrl.dashbordDetails[0]["out_time"] ?? ""}'),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              children: [
                                                _buildDetailItem('Days',
                                                    '${DashboardCtrl.dashbordDetails[0]["prest_days_count"] ?? ""}/${DashboardCtrl.dashbordDetails[0]["no_days"] ?? ""}'),
                                                _buildDetailItem(
                                                    'Last Punch',
                                                    DashboardCtrl
                                                                .dashbordDetails[
                                                            0]["last_punch"] ??
                                                        ""),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                                            builder: (BuildContext context) {
                                              return FullScreenDialog();
                                            },
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'gif/fingerprint.gif',
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
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.grey)),
          Text(value ?? "", style: TextStyle(fontSize: 16)),
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
      insetPadding: EdgeInsets.all(0),
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
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text('This is a full screen dialog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
