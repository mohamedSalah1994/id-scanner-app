import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_data.dart';
import '../components/custom_widgets.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'home.dart';
import 'login.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String id = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 5),
        children: [
          titleText('Sign Up'),
          const SizedBox(height: 17),
          smallText('Add your details to sign up'),
          const SizedBox(height: 26),
          TextField(decoration: kTextFieldDecoration.copyWith(hintText: 'Full Name')),
          const SizedBox(height: 20),
          TextField(decoration: kTextFieldDecoration.copyWith(hintText: 'Username')),
          const SizedBox(height: 20),
          TextField(decoration: kTextFieldDecoration.copyWith(hintText: 'Email')),
          const SizedBox(height: 20),
          TextField(decoration: kTextFieldDecoration),
          const SizedBox(height: 20),
          TextField(decoration: kTextFieldDecoration.copyWith(hintText: 'Confirm Password')),
          const SizedBox(height: 25),
          RoundedButton(
            color: AppData.mainColor,
            child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: () => Get.toNamed(Home.id),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              smallText('Already have an Account? '),
              TextButton(
                onPressed: () => Get.offNamed(Login.id),
                child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
