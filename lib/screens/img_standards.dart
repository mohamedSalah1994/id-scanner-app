import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'add_card.dart';

class ImgStandarads extends StatelessWidget {
  const ImgStandarads({Key? key}) : super(key: key);
  static const String id = '/imgStandarads';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('معايير الصوره'),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
             
              children: [
                SizedBox(
                  height: 16.0.h,
                ),
                Image.asset(
                  'images/flashlight.png',
                  width: 100.0.w,
                  height: 100.0.h,
                ),
                const Text('التأكد من التقاط صورة البطاقة في اضاءه واضحه',
                    textAlign: TextAlign.center),
                 SizedBox(
                  height: 24.0.h,
                ),
                Image.asset(
                  'images/crop-tool.png',
                  width: 100.0.w,
                  height: 100.0.h,
                ),
                const Text(
                    'التأكد من ان تكون جميع حدود صوره البطاقة  بالكامل',
                    textAlign: TextAlign.center),
                 SizedBox(
                  height: 24.0.h,
                ),
                Image.asset(
                  'images/prism.png',
                  width: 100.0.w,
                  height: 100.0.h,
                ),
                const Text('يجب ان لايوجد انعكاس للضوء على الصوره',
                    textAlign: TextAlign.center),
       
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () => Get.toNamed(AddCard.id),
            child: const Icon(Icons.arrow_forward, size: 35),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
