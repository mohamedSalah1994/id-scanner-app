import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_data.dart';

class DrawerLogo extends StatelessWidget {
  const DrawerLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ID ',
          style: TextStyle(
              color: AppData.mainColor,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Scanner',
          style: TextStyle(
              color: AppData.primaryFontColor,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}