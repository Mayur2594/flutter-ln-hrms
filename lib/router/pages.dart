import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
import "package:ln_hrms/models/model.menulists.dart";

final List<GetPage> appPages = [
  GetPage(name: '/', page: () => AuthenticationView()),
  // GetPage(name: '/MainScreen', page: () => MainScreen()),
  GetPage(name: '/MainScreen/attenednace', page: () => AttendanceView()),
  GetPage(name: '/MainScreen/onduty', page: () => OndutyView()),
  GetPage(name: '/MainScreen/leaves', page: () => LeaveView()),
  GetPage(
      name: '/MainScreen/attenednace-regularisation',
      page: () => AttendanceRegularisationView()),
  GetPage(name: '/MainScreen/dashboard', page: () => DashboardView()),
  GetPage(name: '/MainScreen/contacts', page: () => ContactsView()),
  GetPage(name: '/MainScreen/salary', page: () => SalaryView()),
  GetPage(name: '/MainScreen/profile', page: () => ProfileView()),
];

final List<MenuItem> drawerMenuItems = [
  MenuItem(
    title: 'Home',
    url: '/MainScreen/dashboard',
    icon: Icons.home,
    view: DashboardView(),
    description: 'Go to home page',
  ),
  MenuItem(
    title: 'Contacts',
    url: '/MainScreen/contacts',
    icon: Icons.book,
    view: ContactsView(),
    description: 'Learn more about us',
  ),
  MenuItem(
    title: 'Attendance',
    url: '/MainScreen',
    icon: Icons.fingerprint,
    view: AttendanceView(),
    subMenuItems: [
      MenuItem(
        title: 'Att. Records',
        url: '/MainScreen/attenednace',
        icon: Icons.donut_large,
        description: 'View your Attendance Records',
        view: AttendanceView(),
      ),
      MenuItem(
        title: 'Att. Regularisation',
        url: '/MainScreen/attenednace-regularisation',
        icon: Icons.donut_large,
        description: 'View your Attendance Regularisation Records',
        view: AttendanceRegularisationView(),
      ),
      MenuItem(
        title: 'On Duty',
        url: '/MainScreen/onduty',
        icon: Icons.donut_large,
        description: 'View your Onduty Regularisation Records',
        view: OndutyView(),
      ),
      MenuItem(
        title: 'Leaves',
        url: '/MainScreen/leaves',
        icon: Icons.donut_large,
        description: 'View your Leaves Records',
        view: LeaveView(),
      ),
    ],
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Salary',
    url: '/MainScreen/salary',
    icon: Icons.wallet,
    view: SalaryView(),
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Profile',
    url: '/MainScreen/profile',
    icon: Icons.person,
    view: ProfileView(),
    description: 'View your profile',
  ),
];

final List<MenuItem> tabMenuItems = [
  MenuItem(
    title: 'Home',
    url: '/MainScreen/dashboard',
    icon: Icons.home,
    view: DashboardView(),
    description: 'Go to home page',
  ),
  MenuItem(
    title: 'Contacts',
    url: '/MainScreen/contacts',
    icon: Icons.book,
    view: ContactsView(),
    description: 'Learn more about us',
  ),
  MenuItem(
    title: 'Salary',
    url: '/MainScreen/salary',
    icon: Icons.wallet,
    view: SalaryView(),
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Profile',
    url: '/MainScreen/profile',
    icon: Icons.person,
    view: ProfileView(),
    description: 'View your profile',
  ),
];

final List<MenuList> registeredPages = [
  MenuList(
    url: '/forgot-password',
    view: ForgotPasssowrdView(),
  ),
  MenuList(
    url: '/MainScreen/dashboard',
    view: DashboardView(),
  ),
  MenuList(
    url: '/MainScreen/contacts',
    view: ContactsView(),
  ),
  MenuList(url: '/MainScreen/profile', view: ProfileView()),
  MenuList(
    url: '/MainScreen/salary',
    view: SalaryView(),
  ),
  MenuList(
    url: '/MainScreen/attenednace',
    view: AttendanceView(),
  ),
  MenuList(
    url: '/MainScreen/attenednace-regularisation',
    view: AttendanceRegularisationView(),
  ),
  MenuList(
    url: '/MainScreen/onduty',
    view: OndutyView(),
  ),
  MenuList(
    url: '/MainScreen/leaves',
    view: LeaveView(),
  ),
  MenuList(
    url: '/MainScreen/leaves',
    view: LeaveView(),
  ),
];
