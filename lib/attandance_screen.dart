import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/controller/attandance_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

// Your LatLng helper class
class LatLng {
  final double latitude;
  final double longitude;
  LatLng(this.latitude, this.longitude);
}

enum WorkMode { office, work, home }

class LocationScreen extends StatefulWidget {
  final String name;
  const LocationScreen({super.key,required this.name});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WorkMode? selectMode = WorkMode.office; // you can change as needed or get from user
  DateTime datetime = DateTime.now();
  late String formattedTime = DateFormat('hh:mm a').format(datetime);
  late String weekDay = DateFormat('EEEE').format(datetime);
  final AttendanceController controller=Get.find();

  LatLng? currentLatLng;
  bool isInsideCircle = false;
  String? message;

  // Demo: set initial office geofence values
  final LatLng officeLatLng = LatLng(26.8984, 75.7549);
  final double officeRadius = 150; // meters


  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  Future<bool> checkPermission() async {
    if (await Permission.location.isGranted) {
      return true;
    }
    final result = await Permission.location.request();
    return result == PermissionStatus.granted;
  }

  Future<void> determinePosition() async {
    bool permission = await checkPermission();
    if (!permission) {
      setState(() {
        message = 'Location permission is required.';
      });
      return;
    }
    try {
      Position position =
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      LatLng userLoc = LatLng(position.latitude, position.longitude);
      setState(() {
        currentLatLng = userLoc;
        print("Current Location: ${currentLatLng!.latitude}, ${currentLatLng!.longitude}");

      });
      checkGeoFence();
    } catch (e) {
      setState(() {
        message = 'Failed to get location: $e';
      });
    }
  }

  void checkGeoFence() {
    if (currentLatLng == null) return;
    bool inside = false;

    if (selectMode == WorkMode.office) {
      double dist = Geolocator.distanceBetween(
        currentLatLng!.latitude,
        currentLatLng!.longitude,
        officeLatLng.latitude,
        officeLatLng.longitude,
      );
      inside = dist <= officeRadius;
    }
    setState(() {
     isInsideCircle = inside;
    });
  }

  void _checkIn() {
    if(currentLatLng!= null && isInsideCircle){
      controller.checkIn();
    }
    else{
      Get.snackbar('Failure', 'Not in allowed area or location not available');
    }
  }
  void _checkOut() {
    if(currentLatLng!= null && isInsideCircle){
      controller.checkOut();
    }
    else{
      Get.snackbar('Failure', 'Not in allowed area or location not available');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00272E),
      body: currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.bubble_chart_outlined, color: Colors.white),
                  Text(
                    "Hello ${widget.name}",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  CircleAvatar(),
                ],
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glow effect
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.18),
                              blurRadius: 70,
                              spreadRadius: 36,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(weekDay,
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 18)),
                            SizedBox(height: 8),
                            Text(formattedTime,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (message != null) ...[
                SizedBox(height: 16),
                Text(
                  message!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: 12),
              Text(
                'Status: ${isInsideCircle ? "In Allowed Area" : "Not In Allowed Area"}',
                style: TextStyle(
                    color: isInsideCircle ? Colors.green : Colors.grey,
                    fontSize: 16),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: isInsideCircle
                          ? _checkIn
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Check In",
                          style: TextStyle(
                              color:
                              isInsideCircle ? Colors.white : Colors.yellow,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: isInsideCircle
                          ?_checkOut
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                              color:
                              isInsideCircle ? Colors.white : Colors.yellow,
                              fontSize: 16),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
