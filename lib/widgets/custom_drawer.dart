import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:id_scanner/screens/events_with_ids.dart';
import '../app_data.dart';
import '../components/my_text.dart';
import '../controllers/login_controller.dart';
import 'drawer_logo.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: DrawerLogo(),
                ),
                ListTile(
                  leading: Icon(
                    Icons.event_available,
                    color: AppData.mainColor,
                  ),
                  title: const Text('النشاط'),
                  onTap: () {
                    Get.toNamed(
                        EventsWihIds.id); // Navigate and close the Drawer
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: AppData.mainColor,
                  ),
                  title: const Text('تسجيل الخروج'),
                  onTap: () {
                    loginController.sendLogOut(
                        context); // Handle logout and close the Drawer
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyText(
              text: '© 2022 مركز نظم المعلومات المتكامل',
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: AppData.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
