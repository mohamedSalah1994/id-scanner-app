import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:id_scanner/controllers/location_controller.dart';
import 'package:id_scanner/screens/login.dart';

import '../app_data.dart';
import '../components/custom_widgets.dart';
import '../components/my_text.dart';
import '../components/rounded_button.dart';
import '../utils/shared_variable.dart';
import 'home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  static const String id = '/welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  LocationController location = LocationController();

  @override
  void initState() {
    location.getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset('images/id_scanner.png'),
                // child: Image.file(File('/storage/emulated/0/ID Scanner/front-123.jpg')),
                // child: Image.asset('images/empty_id.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    logoText(),
                    const SizedBox(height: 35),
                    smallText(
                      'Scan egyptian identity cards for egyptian people \n to read and extract the text',
                      fontSize: 13,
                    ),
                    const SizedBox(height: 70),
                    RoundedButton(
                      color: AppData.mainColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Let\'s Start',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(width: 50),
                          Icon(Icons.arrow_forward_outlined,
                              color: Colors.white, size: 22),
                        ],
                      ),
                      onPressed: () async {
                        if (LocationController.permission ==
                                LocationPermission.always ||
                            LocationController.permission ==
                                LocationPermission.whileInUse) {
                          Get.offAllNamed(token == null ? Login.id : Home.id);
                        } else {
                          await location.getLocationPermission();
                          if (LocationController.permission ==
                                  LocationPermission.always ||
                              LocationController.permission ==
                                  LocationPermission.whileInUse) {
                            Get.toNamed(Login.id);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          Column(
            children: [
              MyText(
                text: '© 2022  مركز نظم المعلومات المتكامل',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppData.mainColor,
              ),
              const SizedBox(height: 30),
            ],
          ),
          // Divider(color: AppData.primaryFontColor, thickness: 4, indent: 130, endIndent: 130),
        ],
      ),
    );
  }
}
