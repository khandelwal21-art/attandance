import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/controller/login_controller.dart';
import 'package:location/service/attendance_service.dart';
import 'package:location/service/login_service.dart';
import 'controller/attandance_controller.dart';
import 'login.dart';

void main() {
  Get.put(LoginService());
  Get.put(LoginController());
  Get.put(AttendanceService());
  Get.put(AttendanceController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Attandance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:LoginScreen(),
    );
  }
}

