import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessSnackBar(String  title,message) {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.green.shade400,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.check, size: 35 , color: Colors.white,),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.all(16)
  );
}

void showFailedSnackBar(String title , message) {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.red.shade400,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.wifi_off, size: 35 , color: Colors.white,),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.all(16)
  );
}

void showNoInternetConnectionSnackBar() {
  Get.snackbar(
    'تنبيه',
    'لا يوجد اتصال بالشبكه',
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.grey.shade600,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.wifi_off, size: 35, color: Colors.white,),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.all(16)
  );
}

void showLocationAlertSnackBar(String message) {
  Get.snackbar(
    'Alert',
    message,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade400,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.gps_fixed, color: Colors.blue, size: 35),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.all(16)
  );
}

void showRecaptureSnackBar(String  title,message) {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.red.shade400,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.camera_alt_rounded, size: 25, color: Colors.white,),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.all(16)
  );
}
