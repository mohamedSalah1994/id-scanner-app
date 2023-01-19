import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '';
import 'add_card.dart';

class ImgStandarads extends StatelessWidget {
  const ImgStandarads({Key? key}) : super(key: key);
  static const String id = '/imgStandarads';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('معايير الصوره'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/flashlight.png',
                  width: 100.0,
                  height: 100.0,
                ),
                Text('التأكد من التقاط صورة البطاقة في اضاءه واضحه'),
                SizedBox(
                  height: 40.0,
                ),
                Image.asset(
                  'images/crop-tool.png',
                  width: 100.0,
                  height: 100.0,
                ),
                Text('التأكد من ان تكون جميع حدود صوره البطاقة واضحه بالكامل'),
                SizedBox(
                  height: 40.0,
                ),
                Image.asset(
                  'images/prism.png',
                  width: 100.0,
                  height: 100.0,
                ),
                Text('يجب ان لايوجد انعكاس للضوء على الصوره'),
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
