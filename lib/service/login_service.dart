
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class LoginService extends GetxService{

  Future<Map<String,dynamic>> login (String email,String password)async{
    final baseUrl="https://crm.sudotechlabs.com";
    final data=
      {
        "username":email,
        "password":password,
      };
    try{
      final response=await http.post(Uri.parse("$baseUrl/accounts/apilogin/"),headers: {
      "Content-type":"application/json",
       "Accept":"application/json",
      },
      body: jsonEncode(data)
      );

      print(response.body);
      if(response.statusCode==200){
     Get.snackbar("Success", "Login Successful");
     return jsonDecode(response.body);
      }
      else{
        final error = jsonDecode(response.body);
        final errorMessage = error['detail'] ?? error['error'] ?? "Login failed";
        Get.snackbar("Error",errorMessage,backgroundColor: Colors.red);
        return {"error": errorMessage};
      }
    }catch(e){
      Get.snackbar("Error",e.toString());
      return {"error": e.toString()};
    }
  }
}