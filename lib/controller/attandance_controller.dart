import 'package:get/get.dart';
import 'package:location/service/attendance_service.dart';

class AttendanceController extends GetxController {

  final AttendanceService service=Get.find();

    Future<void> checkIn() async {
      await service.checkIn();
    }
  Future<void> checkOut() async {
    await service.checkOut();
  }
  }


