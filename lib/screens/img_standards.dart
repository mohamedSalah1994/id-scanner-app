import 'package:flutter/material.dart';
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'images/flashlight.png',
              width: 100.0,
              height: 100.0,
            ),
            const Text('التأكد من التقاط صورة البطاقة في اضاءه واضحه'),
            const SizedBox(
              height: 40.0,
            ),
            Image.asset(
              'images/crop-tool.png',
              width: 100.0,
              height: 100.0,
            ),
            const Text(
                'التأكد من ان تكون جميع حدود صوره البطاقة واضحه بالكامل'),
            const SizedBox(
              height: 40.0,
            ),
            Image.asset(
              'images/prism.png',
              width: 100.0,
              height: 100.0,
            ),
            const Text('يجب ان لايوجد انعكاس للضوء على الصوره'),
            const Spacer(),
            const Spacer()
          ],
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
