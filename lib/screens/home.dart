import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/controllers/card_controller.dart';
import 'package:id_scanner/controllers/internet_connection_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/cards_list.dart';

import 'dynamic_form.dart';
import 'img_standards.dart';

class Home extends StatefulWidget {
  static const String id = '/home';
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    InternetConnectionController().checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('البطاقات '),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.format_align_center,
                  size: 25,
                ),
                onPressed: () => Get.toNamed(DynamicFrom.id),
              )
            ],
          ),
          body: ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: CardsList(),
          ),
          floatingActionButton: SizedBox(
            width: 60,
            height: 60,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () => Get.toNamed(ImgStandarads.id),
                child: const Icon(Icons.add, size: 35),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

//N6F26Q
