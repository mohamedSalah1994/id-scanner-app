// import 'dart:html';

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:id_scanner/components/show_snack_bar.dart';
import 'package:id_scanner/screens/loginAuth.dart';
import 'package:id_scanner/screens/welcome.dart';

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import '../core/url_path.dart';
import '../screens/home.dart';

import '../utils/shared_variable.dart';

class LoginController extends GetxController {
  // Loading Indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newValue) {
    _isLoading = newValue;
    update();
  }

  var isPaawordHidden = true.obs;
  // ignore: prefer_typing_uninitialized_variables
  var deviceId;
  Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
    } else {
      IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
      deviceId = ios.identifierForVendor;
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future sendLogin(
    BuildContext context,
  ) async {
    await getDeviceInfo();
    Uri url = Uri.parse('${Urls.baseUrl}login');

    var request = http.MultipartRequest('POST', url);

    Map<String, String> data = {
      "username": email.text,
      "password": password.text,
      "DeviceId": deviceId
    };

    request.fields.addAll(data);
    isLoading = true;

    //============================================================
    //============================================================
    try {
      var response = await request.send();
      // var responseDataAsBytes = await response.stream.toBytes();
      // var responseData = json.decode(utf8.decode(responseDataAsBytes));
      // print(responseData);

      var data = await http.Response.fromStream(response);

      if (data.statusCode == 201) {
        CacheHelper.saveData(key: "token", value: data.body).then((value) {
          token = CacheHelper.getData(key: "token");
          isLoading = false;
          Get.offAllNamed(Home.id);
        });
      } else {
        isLoading = false;
        showFailedSnackBar('تنبيه', data.body);
      }
      isLoading = false;
      return data;
    } catch (e) {
      isLoading = false;
      return {};
    }
  }

 Future<void> sendLogOut(BuildContext context) async {
  Uri url = Uri.parse('${Urls.baseUrl}logout');
  String? tokenString = CacheHelper.getData(key: 'token'); // Retrieve the JSON string

  if (tokenString == null) {
    if (kDebugMode) {
      print("No token found. Cannot log out.");
    }
    return; // Early return if there is no token
  }

  Map<String, dynamic> tokenData = json.decode(tokenString); // Parse the JSON string
  String token = tokenData['token']; // Access the token value

  try {
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Remove token from cache after successful logout
      await CacheHelper.removeData(key: "token");
      if (kDebugMode) {
        print("Logged out successfully. Token removed.");
      }

      // Navigate to the Welcome page
      Get.offAllNamed(Welcome.id);
    } else {
      if (kDebugMode) {
        print("Logout failed: ${response.body}");
      }
      messageAlert(response.body, context);
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error during logout: $e");
    }
    messageAlert("An error occurred. Please try again.", context);
  }
}

  void messageAlert(String m, BuildContext context) {
    var snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: '',
        message: m,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
