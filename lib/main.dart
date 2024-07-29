import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/router/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Colors.transparent, // Set to transparent for gradient
          elevation: 5, // Remove shadow if needed
        ),
      ),
      initialRoute: '/dashboard',
      getPages: appPages,
    );
  }
}
