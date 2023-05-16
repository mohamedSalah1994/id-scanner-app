import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/controllers/card_controller.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    
  }
ConnectivityResult connectivityResult = ConnectivityResult.none;
  updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      final CardController cardController = Get.find<CardController>();
      cardController.getEvents();
      Get.rawSnackbar(
          messageText: const Text('أنت الأن متصل بشبكة الواى فاى',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.black54,
          icon: const Icon(
            Icons.wifi,
            color: Colors.white,
            size: 35,
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          snackStyle: SnackStyle.GROUNDED);
    } else if (connectivityResult == ConnectivityResult.mobile) {
      final CardController cardController = Get.find<CardController>();
      cardController.getEvents();
      Get.rawSnackbar(
          messageText: const Text('أنت الأن متصل ببيانات الهاتف',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.black54,
          icon: const Icon(
            Icons.four_g_plus_mobiledata_rounded,
            color: Colors.white,
            size: 35,
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          snackStyle: SnackStyle.GROUNDED);
    } else if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text('الرجاء الاتصال بالإنترنت',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.black54,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          snackStyle: SnackStyle.GROUNDED);
    }
  }
}
