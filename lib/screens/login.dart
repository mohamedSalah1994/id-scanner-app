import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:id_scanner/components/alert_exit_app.dart';
import 'package:id_scanner/widgets/internet_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../app_data.dart';
import '../components/custom_widgets.dart';

import '../controllers/login_controller.dart';

class Login extends StatefulWidget {
  static const String id = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    Get.put(LoginController());

    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
          body: WillPopScope(
        onWillPop: alertExitApp,
        child: InterNetWidget(
          widget: ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              color: AppData.mainColor,
            ),
            inAsyncCall: controller.isLoading,
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  'images/id_scanner.png',
                  width: screenWidth,
                  height: screenHeight * 0.33,
                ),
                logoText(),

                SizedBox(height: 8.h),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "هذا الحقل مطلوب";
                            }
                            return null;
                          },
                          cursorColor: AppData.mainColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppData.mainColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                        SizedBox(height: 16.h),
                        Obx(
                          () => TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "هذا الحقل مطلوب";
                              }
                              return null;
                            },
                            cursorColor: AppData.mainColor,
                            obscureText: controller.isPaawordHidden.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppData.mainColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            padding: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: AppData.mainColor,
                            child: Text('تسجيل الدخول',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!
                                    .save(); // Save the form values
                                controller.sendLogin(context);
                              } else {
                                autovalidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ));
    });
  }
}
