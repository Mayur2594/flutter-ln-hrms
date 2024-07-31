import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/customwidgets/widget.applayout.dart';
import 'package:ln_hrms/customwidgets/widget.shimmers.dart';
import 'package:ln_hrms/controllers/controller.attendance.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController attendanceCtrl = Get.find();
    return Scaffold(
        appBar: AppBarView(),
        drawer: const DrawerView(),
        body: RefreshIndicator(
            onRefresh: () => attendanceCtrl.refreshPage(),
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          attendanceCtrl.filterAttendance(value);
                        },
                      ),
                    ),
                  ),
                ),
                body: Obx(() {
                  // ignore: invalid_use_of_protected_member
                  if (attendanceCtrl.loadingContacts.value == true) {
                    return const ListShimmerLoader();
                  } else {
                    if (attendanceCtrl.filteredAttendanceList.value.isEmpty) {
                      return const Column(
                        children: [Text("No Records Found")],
                      );
                    } else {
                      return ListView.separated(
                          // ignore: invalid_use_of_protected_member
                          itemCount: attendanceCtrl
                              .filteredAttendanceList.value.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            // ignore: invalid_use_of_protected_member
                            final item = attendanceCtrl
                                .filteredAttendanceList.value[index];
                            return Container(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        child: Text(item['att_day']),
                                      ),
                                      Text(
                                        item['att_month'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0.0, 0, 12.0, 0),
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "In Time",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  item['in_time'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                12.0, 0, 12.0, 0),
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "Out Time",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  item['out_time'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                12.0, 0, 12.0, 0),
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "Late Time",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  attendanceCtrl
                                                      .getTimeDifference(item),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: PopupMenuButton<String>(
                                              icon: const Icon(Icons
                                                  .more_vert), // The icon that triggers the menu
                                              onSelected: (String result) {
                                                // Handle the selected value
                                                print('Selected: $result');
                                              },
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .visibility_outlined),
                                                      Text(" View Details")
                                                    ],
                                                  ),
                                                ),
                                                const PopupMenuItem<String>(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.update),
                                                      Text(
                                                          " Attendnce Regularise")
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        decoration: const BoxDecoration(
                                          border: BorderDirectional(
                                              top: BorderSide(
                                                  width: .5,
                                                  color: Colors.black45)),
                                        ),
                                        child: item['regularisation_approval_status']
                                                        .toString()
                                                        .trim() !=
                                                    "" &&
                                                item['regularisation_approval_status']
                                                        .toString()
                                                        .trim() !=
                                                    'null'
                                            ? Text(
                                                "Applied for attendance regularisation (${item['regularisation_approval_status'] == 0 ? "Pending" : item['regularisation_approval_status'] == 1 ? "Approved" : item['regularisation_approval_status'] == 2 ? "Denied" : ""})",
                                                style: TextStyle(
                                                    color: item['regularisation_approval_status'] ==
                                                            0
                                                        ? Colors.amber
                                                        : item['regularisation_approval_status'] ==
                                                                1
                                                            ? Colors.green
                                                            : item['regularisation_approval_status'] ==
                                                                    2
                                                                ? Colors.red
                                                                : null),
                                              )
                                            : null,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }
                }))));
  }
}
