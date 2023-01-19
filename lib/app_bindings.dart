import 'package:get/get.dart';
import 'package:id_scanner/controllers/card_controller.dart';
import 'package:id_scanner/controllers/internet_connection_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CardController());
    Get.put(InternetConnectionController(), permanent: true);
  }
}
