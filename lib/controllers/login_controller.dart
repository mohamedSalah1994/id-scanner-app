
// import 'dart:html';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:id_scanner/screens/loginAuth.dart';
import 'package:id_scanner/screens/welcome.dart';

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import '../screens/home.dart';

import '../utils/shared_variable.dart';

class LoginController extends GetxController {
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
    Uri url = Uri.parse('https://41.218.156.154/reader/login');
    var request = http.MultipartRequest('POST', url);

    Map<String, String> data = {
      "username": email.text,
      "password": password.text,
      "DeviceId": deviceId
    };
    request.fields.addAll(data);
    

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

          

          Get.offAllNamed(Home.id);
        });
      } else {
        massage(data.body, context);
      }

      return data;
    } catch (e) {
     
      return {};
    }
  }

  Future sendLogOut(
    BuildContext context,
  ) async {
    Uri url = Uri.parse('https://41.218.156.154/reader/logout');
    var request = http.MultipartRequest('POST', url);

    Map<String, String> data = {
      "username": email.text,
      "password": password.text,
    };
    request.fields.addAll(data);

    //============================================================
    //============================================================
    try {
      var response = await request.send();
      // var responseDataAsBytes = await response.stream.toBytes();
      // var responseData = json.decode(utf8.decode(responseDataAsBytes));
      // print(responseData);

      // CacheHelper.saveData(key: "token",value: ).then((value){
      //   token = CacheHelper.getData(key: "token");
      //
      // });
      var data = await http.Response.fromStream(response);
     

      if (data.statusCode == 201) {
        CacheHelper.removeData(key: "token").then((value) {
          token = CacheHelper.getData(key: "token");
          Get.toNamed(Welcome.id);
        });
      } else {
        massage(data.body, context);
      }

      return data;
    } catch (e) {
      
      return {};
    }
  }

  void massage(String m, BuildContext context) {
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
