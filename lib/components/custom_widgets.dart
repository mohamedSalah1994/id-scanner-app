import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_data.dart';
import 'my_text.dart';

Column logoText() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ID ',
            style: TextStyle(color: AppData.mainColor, fontSize: 48.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            'Scanner',
            style: TextStyle(color: AppData.primaryFontColor, fontSize: 48.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      // const SizedBox(height: 5),
      Text(
        'Text Recognition',
        textAlign: TextAlign.center,
        style:
            TextStyle(color: AppData.primaryFontColor, fontSize: 10.sp, letterSpacing: 2.5, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

Text smallText(String text, {double fontSize = 14}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: AppData.secondaryFontColor, fontWeight: FontWeight.w500, fontSize: fontSize),
  );
}

Text titleText(String text, {double fontSize = 30}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: AppData.primaryFontColor, fontSize: fontSize, fontWeight: FontWeight.bold),
  );
}

MyText inputLabel(String text) {
  return MyText(
    text: text,
    color: AppData.primaryFontColor,
    containerAlignment: Alignment.centerRight,
    fontSize: 17,
    fontWeight: FontWeight.w500,
    
  );
}
