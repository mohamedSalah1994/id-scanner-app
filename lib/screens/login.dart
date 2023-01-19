import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_data.dart';
import '../components/custom_widgets.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../controllers/login_controller.dart';

class Login extends StatelessWidget {
  static const String id = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 5),
          child: ListView(
            children: [
              titleText('Login'),
              const SizedBox(height: 17),
              smallText('Add your details to login'),
              const SizedBox(height: 35),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Your username'),
                controller: controller.email,
              ),
              const SizedBox(height: 25),
              Obx(
                () => TextField(
                  obscureText: controller.isPaawordHidden.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: AppData.mainColor,
                child: const Text('Login',
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
