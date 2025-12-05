import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/service/login_service.dart';

import '../attandance_screen.dart';

class LoginController extends GetxController{
  final LoginService service=Get.find();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  Future<void> login()async{
    try{
      final result =await service.login(emailController.text,passwordController.text);

      final name=result['data']['name'] ?? 'User';
      if (result.containsKey('status') && result['status'] == true) {
        Get.offAll(() =>LocationScreen(name:name));
      }
      }catch(e){
      Get.snackbar("Error", e.toString());

    }

  }
}