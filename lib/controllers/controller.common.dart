import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/models/model.menulists.dart';
import 'package:ln_hrms/router/pages.dart';
import 'package:ln_hrms/views/view.authentication.dart';
import 'package:ln_hrms/views/view.forgotpassword.dart';
import 'package:ln_hrms/views/view.attendance.dart';
import 'package:ln_hrms/views/view.onduty.dart';
import 'package:ln_hrms/views/view.leaves.dart';
import 'package:ln_hrms/views/view.attendance_regularisation.dart';
import 'package:ln_hrms/views/view.contacts.dart';
import 'package:ln_hrms/views/view.dahboard.dart';
import 'package:ln_hrms/views/view.profile.dart';
import 'package:ln_hrms/views/view.salary.dart';
import 'package:ln_hrms/main.dart';

class CommonController extends GetxController {
  redirectToPage(String pageURL) {
    // ignore: non_constant_identifier_names
    List<MenuList> PagesList = registeredPages
        .where((pgs) => pgs.url == pageURL.toString().trim())
        .toList();
    print(PagesList[0]);
    Get.to(PagesList[0].view);
  }
}
