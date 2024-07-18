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
import "package:ln_hrms/models/model.menulists.dart";
import "package:ln_hrms/bindings/binding.dart";

final List<GetPage> appPages = [
  GetPage(
      name: '/',
      page: () => AuthenticationView(),
      binding: AuthenticationBinding()),
  // GetPage(name: '/MainScreen', page: () => MainScreen()),
  GetPage(name: '/attenednace', page: () => AttendanceView()),
  GetPage(name: '/onduty', page: () => OndutyView()),
  GetPage(name: '/leaves', page: () => LeaveView()),
  GetPage(
      name: '/attenednace-regularisation',
      page: () => AttendanceRegularisationView()),
  GetPage(
      name: '/dashboard',
      page: () => DashboardView(),
      binding: DashboardBinding()),
  GetPage(
      name: '/contacts',
      page: () => ContactsView(),
      binding: ContactsBinding()),
  GetPage(name: '/salary', page: () => SalaryView()),
  GetPage(name: '/profile', page: () => ProfileView()),
];

final List<MenuItem> drawerMenuItems = [
  MenuItem(
    title: 'Home',
    url: '/dashboard',
    icon: Icons.home,
    view: DashboardView(),
    description: 'Go to home page',
  ),
  MenuItem(
    title: 'Contacts',
    url: '/contacts',
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
        url: '/attenednace',
        icon: Icons.donut_large,
        description: 'View your Attendance Records',
        view: AttendanceView(),
      ),
      MenuItem(
        title: 'Att. Regularisation',
        url: '/attenednace-regularisation',
        icon: Icons.donut_large,
        description: 'View your Attendance Regularisation Records',
        view: AttendanceRegularisationView(),
      ),
      MenuItem(
        title: 'On Duty',
        url: '/onduty',
        icon: Icons.donut_large,
        description: 'View your Onduty Regularisation Records',
        view: OndutyView(),
      ),
      MenuItem(
        title: 'Leaves',
        url: '/leaves',
        icon: Icons.donut_large,
        description: 'View your Leaves Records',
        view: LeaveView(),
      ),
    ],
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Salary',
    url: '/salary',
    icon: Icons.wallet,
    view: SalaryView(),
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Profile',
    url: '/profile',
    icon: Icons.person,
    view: ProfileView(),
    description: 'View your profile',
  ),
];

final List<MenuItem> tabMenuItems = [
  MenuItem(
    title: 'Home',
    url: '/dashboard',
    icon: Icons.home,
    view: DashboardView(),
    description: 'Go to home page',
  ),
  MenuItem(
    title: 'Contacts',
    url: '/contacts',
    icon: Icons.book,
    view: ContactsView(),
    description: 'Learn more about us',
  ),
  MenuItem(
    title: 'Salary',
    url: '/salary',
    icon: Icons.wallet,
    view: SalaryView(),
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Profile',
    url: '/profile',
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
    url: '/dashboard',
    view: DashboardView(),
  ),
  MenuList(
    url: '/contacts',
    view: ContactsView(),
  ),
  MenuList(url: '/profile', view: ProfileView()),
  MenuList(
    url: '/salary',
    view: SalaryView(),
  ),
  MenuList(
    url: '/attenednace',
    view: AttendanceView(),
  ),
  MenuList(
    url: '/attenednace-regularisation',
    view: AttendanceRegularisationView(),
  ),
  MenuList(
    url: '/onduty',
    view: OndutyView(),
  ),
  MenuList(
    url: '/leaves',
    view: LeaveView(),
  ),
  MenuList(
    url: '/leaves',
    view: LeaveView(),
  ),
];
