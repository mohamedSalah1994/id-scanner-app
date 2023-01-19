import 'dart:io';

import 'package:get/get.dart';

class InternetConnectionController extends GetxController {
  // Loading Indicator
  bool _online = false;
  bool get online => _online;

  @override
  void onInit() async {
    super.onInit();
    await checkConnection();
  }

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("connect");
        _online = true;
      } else {
        print("not connect");
        _online = false;
      }
    } on SocketException catch (_) {
      print("not connect");
      _online = false;
    }
    update();
  }
}
