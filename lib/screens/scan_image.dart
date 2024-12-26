import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:id_scanner/controllers/card_controller.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../app_data.dart';
import '../models/card_data.dart';
import '../models/card_model.dart';
import 'id_report.dart';

class ScanImage extends StatefulWidget {
  const ScanImage({Key? key}) : super(key: key);
  static const String id = '/scan_image';

  @override
  State<ScanImage> createState() => _ScanImageState();
}

class _ScanImageState extends State<ScanImage> {
  late final CardData cardData;
  late final List<TextEditingController> controllers;

  List<bool> changedList = List.generate(6, (index) => false);

  @override
  void initState() {
    super.initState();
    cardData = Get.arguments;
    controllers = [
      TextEditingController(text: cardData.name!),
      TextEditingController(text: cardData.address!),
      TextEditingController(text: cardData.job!),
      TextEditingController(text: cardData.religion!),
      TextEditingController(text: cardData.maritalStatus!),
      TextEditingController(text: cardData.hus!),
    ];
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildField(
      String label, TextEditingController controller, int index) {
    return Row(
      children: [
        SizedBox(
          width: 120.0,
          child: Text(
            '$label:',
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => changedList[index] = true,
          ),
        ),
      ],
    );
  }

  Widget _buildStaticField(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 120.0,
          child: Text(
            '$label:',
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Widget _getImage(String encodedImage) {
    Uint8List decodedImage = base64Decode(encodedImage);
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: MemoryImage(decodedImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('بيانات البطاقة'),
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                  onPressed: () => Get.toNamed(
                    IDReport.id,
                    arguments: {
                      'cardData': cardData,
                      'updatedData': {
                        'name': controllers[0].text,
                        'address': controllers[1].text,
                        'job': controllers[2].text,
                        'religion': controllers[3].text,
                        'maritalStatus': controllers[4].text,
                        'hus': controllers[5].text,
                      },
                    },
                  ),
                  icon: const Icon(Icons.note, size: 25),
                ),
              ],
            ),
            body: ModalProgressHUD(
              progressIndicator:
                  CircularProgressIndicator(color: AppData.mainColor),
              inAsyncCall: controller.isLoading,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    height: 150,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ImageSlideshow(
                            children: [
                              _getImage(cardData.croppedFrontImage.toString()),
                              _getImage(cardData.croppedBackImage.toString()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: _getImage(
                                    cardData.croppedPersonalImage.toString()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildStaticField(
                            'الرقم القومى', cardData.nationalId ?? ''),
                        const SizedBox(height: 30.0),
                        _buildField('الإسم', controllers[0], 0),
                        const SizedBox(height: 20.0),
                        _buildField('العنوان', controllers[1], 1),
                        const SizedBox(height: 20.0),
                        _buildField('الوظيفة', controllers[2], 2),
                        const SizedBox(height: 20.0),
                        _buildStaticField('النوع', cardData.gender ?? ''),
                        const SizedBox(height: 20.0),
                        _buildField('الديانة', controllers[3], 3),
                        const SizedBox(height: 20.0),
                        _buildField('الحالة الإجتماعية', controllers[4], 4),
                        const SizedBox(height: 25.0),
                        _buildStaticField(
                            'تاريخ الميلاد', cardData.birthdate ?? ''),
                        const SizedBox(height: 25.0),
                        _buildStaticField(
                            'محل الميلاد', cardData.birthPlace ?? ''),
                        if (cardData.hus != null &&
                            cardData.hus!.isNotEmpty) ...[
                          const SizedBox(height: 20.0),
                          _buildField('اسم الزوج', controllers[5], 5),
                        ],
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      CardModel card = CardModel();
                      card.id = '${cardData.nationalId}-${DateTime.now()}';
                      controller.sendData(
                        cardData,
                        context,
                        controllers[0].text,
                        controllers[1].text,
                        controllers[2].text,
                        controllers[3].text,
                        controllers[4].text,
                        controllers[5].text,
                        changedList,
                      );
                    },
                    child: Container(
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Text(
                        'حفظ البيانات',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
