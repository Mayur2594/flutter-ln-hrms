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
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding()),
  // GetPage(name: '/MainScreen', page: () => MainScreen()),
  GetPage(name: '/attenednace', page: () => const AttendanceView()),
  GetPage(name: '/onduty', page: () => const OndutyView()),
  GetPage(name: '/leaves', page: () => const LeaveView()),
  GetPage(
      name: '/attenednace-regularisation',
      page: () => const AttendanceRegularisationView()),
  GetPage(
      name: '/dashboard',
      page: () => const DashboardView(),
      binding: DashboardBinding()),
  GetPage(
      name: '/contacts',
      page: () => const ContactsView(),
      binding: ContactsBinding()),
  GetPage(name: '/salary', page: () => const SalaryView()),
  GetPage(name: '/profile', page: () => const ProfileView()),
];

final List<MenuItem> drawerMenuItems = [
  MenuItem(
    title: 'Home',
    url: '/dashboard',
    icon: Icons.home,
    view: const DashboardView(),
    description: 'Go to home page',
  ),
  MenuItem(
    title: 'Contacts',
    url: '/contacts',
    icon: Icons.book,
    view: const ContactsView(),
    description: 'Learn more about us',
  ),
  MenuItem(
    title: 'Attendance',
    url: '/MainScreen',
    icon: Icons.fingerprint,
    view: const AttendanceView(),
    subMenuItems: [
      MenuItem(
        title: 'Att. Records',
        url: '/attenednace',
        icon: Icons.donut_large,
        description: 'View your Attendance Records',
        view: const AttendanceView(),
      ),
      MenuItem(
        title: 'Att. Regularisation',
        url: '/attenednace-regularisation',
        icon: Icons.donut_large,
        description: 'View your Attendance Regularisation Records',
        view: const AttendanceRegularisationView(),
      ),
      MenuItem(
        title: 'On Duty',
        url: '/onduty',
        icon: Icons.donut_large,
        description: 'View your Onduty Regularisation Records',
        view: const OndutyView(),
      ),
      MenuItem(
        title: 'Leaves',
        url: '/leaves',
        icon: Icons.donut_large,
        description: 'View your Leaves Records',
        view: const LeaveView(),
      ),
    ],
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Salary',
    url: '/salary',
    icon: Icons.wallet,
    view: const SalaryView(),
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Profile',
    url: '/profile',
    icon: Icons.person,
    view: const ProfileView(),
    description: 'View your profile',
  ),
];

final List<MenuItem> tabMenuItems = [
  MenuItem(
    title: 'Home',
    url: '/dashboard',
    icon: Icons.home,
    view: const DashboardView(),
    description: 'Go to home page',
  ),
  MenuItem(
    title: 'Contacts',
    url: '/contacts',
    icon: Icons.book,
    view: const ContactsView(),
    description: 'Learn more about us',
  ),
  MenuItem(
    title: 'Salary',
    url: '/salary',
    icon: Icons.wallet,
    view: const SalaryView(),
    description: 'Adjust your preferences',
  ),
  MenuItem(
    title: 'Profile',
    url: '/profile',
    icon: Icons.person,
    view: const ProfileView(),
    description: 'View your profile',
  ),
];

final List<MenuList> registeredPages = [
  MenuList(
    url: '/forgot-password',
    view: const ForgotPasssowrdView(),
  ),
  MenuList(
    url: '/dashboard',
    view: const DashboardView(),
  ),
  MenuList(
    url: '/contacts',
    view: const ContactsView(),
  ),
  MenuList(url: '/profile', view: const ProfileView()),
  MenuList(
    url: '/salary',
    view: const SalaryView(),
  ),
  MenuList(
    url: '/attenednace',
    view: const AttendanceView(),
  ),
  MenuList(
    url: '/attenednace-regularisation',
    view: const AttendanceRegularisationView(),
  ),
  MenuList(
    url: '/onduty',
    view: const OndutyView(),
  ),
  MenuList(
    url: '/leaves',
    view: const LeaveView(),
  ),
  MenuList(
    url: '/leaves',
    view: const LeaveView(),
  ),
];
