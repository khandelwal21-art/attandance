import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AttendanceService extends GetxService{
  final baseUrl="https://crm.sudotechlabs.com";
  Future<void> checkIn()async{
  try{
  final result= await http.post(Uri.parse("$baseUrl/accounts/checkin/"),
  headers: {
    "Authorization": "Bearer 9740bb33d0cafcd2d7660df9f7552a5c9e9c23bb ",
    "Content-type":"application/json",
    "Accept":"application/json",
  },);

  print(result.body);
  if(result.statusCode==200){
    Get.snackbar('Success', 'Checked in Successfully');
  }
  }catch(e){
    Get.snackbar('Failure',e.toString() );

  }
}
  Future<void> checkOut()async{
    try{
      final result= await http.post(Uri.parse("$baseUrl/accounts/checkout/"));
      print(result.body);
      if(result.statusCode==200){
        Get.snackbar('Success', 'Checked Out Successfully');
      }
    }catch(e){
      Get.snackbar('Failure',e.toString() );

    }
  }

}
