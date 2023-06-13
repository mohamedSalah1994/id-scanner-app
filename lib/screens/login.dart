import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/components/alert_exit_app.dart';
import 'package:id_scanner/widgets/internet_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../app_data.dart';
import '../components/custom_widgets.dart';

import '../controllers/login_controller.dart';

class Login extends StatelessWidget {
  static const String id = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppData.mainColor,
            title: const Text('تسجيل الدخول'),
          ),
          body: WillPopScope(
            onWillPop: alertExitApp,
            child: InterNetWidget(
          widget: ModalProgressHUD(
             progressIndicator: CircularProgressIndicator(
                  color: AppData.mainColor,
                ),
            inAsyncCall: controller.isLoading,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    logoText(),

                    const SizedBox(height: 50),

                    TextField(
                      cursorColor: AppData.mainColor,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppData.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppData.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'اسم المستخدم',
                           labelStyle: TextStyle(
                            color: AppData.primaryFontColor,
                          ),
                          ),
                      controller: controller.email,
                    ),
                    const SizedBox(height: 15),
                    Obx(
                      () => TextField(
                        cursorColor: AppData.mainColor,
                        obscureText: controller.isPaawordHidden.value,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppData.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppData.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'كلمة المرور',
                          labelStyle: TextStyle(
                            color: AppData.primaryFontColor,
                          ),
                          suffix: InkWell(
                            child: Icon(
                              controller.isPaawordHidden.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                              size: 20,
                            ),
                            onTap: () {
                              controller.isPaawordHidden.value =
                                  !controller.isPaawordHidden.value;
                            },
                          ),
                        ),
                        controller: controller.password,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MaterialButton(
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: AppData.mainColor,
                      child: const Text('تسجيل الدخول',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      onPressed: () {
                        controller.sendLogin(context);
                      },
                    ),

                    // const SizedBox(height: 40),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     smallText('Don\'t have an Account? '),
                    //     TextButton(
                    //       onPressed: () => Get.offNamed(SignUp.id),
                    //       child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
            
          ));
    });
  }
}
