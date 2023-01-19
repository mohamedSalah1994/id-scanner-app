import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessSnackBar(String message) {
  Get.snackbar(
    '',
    message,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.green.shade400,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.check, size: 35),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
  );
}

void showFailedSnackBar(String message) {
  Get.snackbar(
    '',
    message,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade400,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.wifi_off, size: 35),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
  );
}

void showNoInternetConnectionSnackBar() {
  Get.snackbar(
    'Alert',
    'No Internet Connection!',
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.grey.shade600,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.wifi_off, size: 35),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
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
  );
}

void showRecaptureSnackBar(String message) {
  Get.snackbar(
    '',
    message,
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.red.shade400,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    icon: const Icon(Icons.camera_alt_rounded, size: 25),
    shouldIconPulse: false,
    padding: const EdgeInsets.all(20),
  );
}
