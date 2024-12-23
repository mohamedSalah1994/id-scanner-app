import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:id_scanner/components/alert_exit_app.dart';
import 'package:id_scanner/controllers/location_controller.dart';


import '../app_data.dart';
import '../components/custom_widgets.dart';
import '../components/my_text.dart';
import '../components/rounded_button.dart';

import 'home.dart';
import 'login.dart';
import 'loginAuth.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  static const String id = '/welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // LocationController location = LocationController();

  @override
  void initState() {
    // location.getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    String? tokenString =
        CacheHelper.getData(key: 'token'); // Retrieve the JSON string
    bool isLoggedIn = tokenString != null;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: alertExitApp,
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight * 0.95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'images/id_scanner.png',
                            width: screenWidth,
                            height: screenHeight * 0.33,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                            ),
                            child: Column(
                              children: [
                                logoText(),
                                SizedBox(height: 24.h),
                                smallText(
                                  isLoggedIn
                                      ? "مرحبًا بعودتك!"
                                      : "مرحبًا! يرجى تسجيل الدخول.",
                                  fontSize: 16.sp,
                                ),
                                SizedBox(height: 24.h),
                                RoundedButton(
                                  color: AppData.mainColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                            isLoggedIn
                                                ? "إبدأ الأن"
                                                : "  تسجيل الدخول",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp)),
                                      ),
                                       SizedBox(width: 50.w),
                                      Icon(Icons.arrow_forward_outlined,
                                          color: Colors.white, size: 24.sp),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (isLoggedIn) {
                                      Get.offAllNamed(Home.id);
                                    } else {
                                      Get.offAllNamed(Login.id);
                                    }
                                  },
                                ),
                              
                              ],
                            ),
                          ),
                        ],
                      ),
                      MyText(
                        text: '© 2022  مركز نظم المعلومات المتكامل',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: AppData.mainColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
