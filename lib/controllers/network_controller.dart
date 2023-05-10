import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/controllers/card_controller.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      
      Get.rawSnackbar(
          messageText: const Text('YOU ARE CONNECTED TO WIFI',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green[400]!,
          icon: const Icon(
            Icons.wifi,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          snackStyle: SnackStyle.GROUNDED);
    } else if (connectivityResult == ConnectivityResult.mobile) {
      Get.rawSnackbar(
          messageText: const Text('YOU ARE CONNECTED TO MODILE DATA',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green[400]!,
          icon: const Icon(
            Icons.four_g_plus_mobiledata_rounded,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          snackStyle: SnackStyle.GROUNDED);
    } else {
      Get.rawSnackbar(
          messageText: const Text('PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          snackStyle: SnackStyle.GROUNDED);
    }
  }
}
