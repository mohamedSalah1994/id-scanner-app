import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_text.dart';

Future<void> kAlertDialog({
  required String content,
  required Function() onConfirm,
  String confirmText = 'حذف',
}) async {
  await Get.defaultDialog(
    title: 'تنبيه',
    titlePadding: const EdgeInsets.symmetric(vertical: 15),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    content: MyText(text: content),
    cancel:
        TextButton(onPressed: () => Get.back(), child: const Text('رجوع')),
    confirm: TextButton(
      onPressed: () {
        onConfirm();
        Get.back();
      },
      child: Text(confirmText , style: const TextStyle(color: Colors.red),),
    ),
  );
}
