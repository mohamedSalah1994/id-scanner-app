import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:id_scanner/screens/add_card.dart';
import 'package:id_scanner/screens/dynamic_form.dart';
import 'package:id_scanner/screens/edit_card.dart';
import 'package:id_scanner/screens/events_with_ids.dart';
import 'package:id_scanner/screens/home.dart';
import 'package:id_scanner/screens/id_report.dart';
import 'package:id_scanner/screens/img_standards.dart';
import 'package:id_scanner/screens/login.dart';
import 'package:id_scanner/screens/loginAuth.dart';
import 'package:id_scanner/screens/scan_image.dart';
import 'package:id_scanner/screens/sign_up.dart';
import 'package:id_scanner/screens/welcome.dart';
import 'package:id_scanner/utils/shared_variable.dart';
import 'package:provider/provider.dart';

import 'app_bindings.dart';
import 'controllers/connectivity_provider.dart';
import 'controllers/login_controller.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LoginController());
  await CacheHelper.init();
  token = CacheHelper.getData(key: "token");
  runApp(ChangeNotifierProvider(
    create: (_) => ConactivityProvider()..initConnectivity(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
       return GetMaterialApp(
          theme: ThemeData(textTheme: GoogleFonts.cairoTextTheme()),
          debugShowCheckedModeBanner: false,
          initialBinding: AppBindings(),
          initialRoute: Welcome.id,
          textDirection: TextDirection.rtl,
          getPages: [
            GetPage(name: Welcome.id, page: () => const Welcome()),
            GetPage(name: Login.id, page: () => const Login()),
            GetPage(name: SignUp.id, page: () => const SignUp()),
            GetPage(name: Home.id, page: () => const Home()),
            GetPage(name: ScanImage.id, page: () => const ScanImage()),
            GetPage(name: AddCard.id, page: () => const AddCard()),
            GetPage(name: ImgStandarads.id, page: () => const ImgStandarads()),
            GetPage(name: EditCard.id, page: () => const EditCard()),
            GetPage(name: DynamicFrom.id, page: () => const DynamicFrom()),
            GetPage(name: IDReport.id, page: () => const IDReport()),
            GetPage(name: EventsWihIds.id, page: () => const EventsWihIds()),
          ],
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// The standard ID-1 or CR80 ID card size in pixels is 1012 pixels wide by 638 high at 300 dpi.
