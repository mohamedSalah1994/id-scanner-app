import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:id_scanner/controllers/card_controller.dart';
import 'package:id_scanner/utils/shared_variable.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  CardData cardData = Get.arguments;
  int fieldId = 0;

  List<bool> changedList = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  // TextEditingController birthdateController = TextEditingController();
  // TextEditingController birthPlaceController = TextEditingController();
  TextEditingController husController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardController>(
        builder: (controller) {
          nameController.text = cardData.name!;
          addressController.text = cardData.address!;
          jobController.text = cardData.job!;
          // genderController.text = cardData.gender!;
          religionController.text = cardData.religion!;
          maritalStatusController.text = cardData.maritalStatus!;
          // birthdateController.text = cardData.birthdate!;
          //  birthPlaceController.text = cardData.birthPlace!;
          husController.text = cardData.hus!;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('بيانات البطاقة'),
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                    onPressed: () => Get.toNamed(IDReport.id),
                    icon: const Icon(Icons.note, size: 25))
              ],
            ),
            body: ModalProgressHUD(
              inAsyncCall: controller.isLoading,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8 , vertical: 8),
                    height: 150,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: ImageSlideshow(
                              children: [
                                _getImage(
                                    cardData.croppedFrontImage.toString()),
                                _getImage(cardData.croppedBackImage.toString())
                              ],
                            )),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                  child: _getImage(cardData.croppedPersonalImage
                                      .toString())),
                              // Expanded(child: Container(color: Colors.grey, margin: const EdgeInsets.all(2))),
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
                        // national_id
                        Row(children: [
                          const SizedBox(
                            width: 120.0,
                            child: Text(
                              'الرقم القومى :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: Text(
                              '${cardData.nationalId}',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 30.0,
                        ),
                        //name
                        Row(children: [
                          const SizedBox(
                            width: 70.0,
                            child: Text(
                              'الإسم :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                              child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.blue),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (v) {
                              changedList[0] = true;
                            },
                          )),
                        ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        //address
                        Row(children: [
                          const SizedBox(
                            width: 70.0,
                            child: Text(
                              'العنوان :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: TextField(
                              controller: addressController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (v) {
                                changedList[1] = true;
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // job
                        Row(children: [
                          const SizedBox(
                            width: 70.0,
                            child: Text(
                              'الوظيفة :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: TextField(
                              controller: jobController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (v) {
                                changedList[2] = true;
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // gender
                        Row(children: [
                          const SizedBox(
                            width: 70.0,
                            child: Text(
                              'النوع :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: Text(
                              '${cardData.gender}',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // religion
                        Row(children: [
                          const SizedBox(
                            width: 70.0,
                            child: Text(
                              'الديانة :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: TextField(
                              controller: religionController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (v) {
                                changedList[3] = true;
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // marital_status
                        Row(children: [
                          const SizedBox(
                            width: 70.0,
                            child: Text(
                              'الحالة الإجتماعية :',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: TextField(
                              controller: maritalStatusController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (v) {
                                changedList[4] = true;
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // birthdate
                        Row(children: [
                          const SizedBox(
                            width: 120.0,
                            child: Text(
                              'تاريخ الميلاد :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: Text(
                              '${cardData.birthdate}',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // birth_place
                        Row(children: [
                          const SizedBox(
                            width: 120.0,
                            child: Text(
                              'محل الميلاد :',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // Optional
                          Expanded(
                            child: Text(
                              '${cardData.birthPlace}',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // hus
                        husController.text == ""
                            ? const SizedBox()
                            : Row(children: [
                                const SizedBox(
                                  width: 70.0,
                                  child: Text(
                                    'اسم الزوج :',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),

                                // Optional
                                Expanded(
                                  child: TextField(
                                    onChanged: (v) {
                                      changedList[5] = true;
                                    },
                                    controller: husController,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.blue),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ]),
                      ],
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     // national_id
                  //     _identityField(
                  //         fName: 'الرقم القومى ', fValue: cardData.nationalId),
                  //
                  //     // expiration_date
                  //     // _identityField(
                  //     //     fName: 'تاريخ الإنتهاء ',
                  //     //     fValue: cardData.expirationDate),
                  //     // name
                  //     _identityField(fName: 'الإسم ', fValue: cardData.name),
                  //
                  //     // address
                  //     _identityField(
                  //         fName: 'العنوان ', fValue: cardData.address),
                  //     // job
                  //     _identityField(fName: 'الوظيفة ', fValue: cardData.job),
                  //     // gender
                  //     _identityField(fName: 'النوع ', fValue: cardData.gender),
                  //     // religion
                  //     _identityField(
                  //         fName: 'الديانة ', fValue: cardData.religion),
                  //     // marital_status
                  //     _identityField(
                  //         fName: 'الحالة الإجتماعية ',
                  //         fValue: cardData.maritalStatus),
                  //     // release_date
                  //     // _identityField(
                  //     //     fName: 'تاريخ الإصدار', fValue: cardData.releaseDate),
                  //     // birthdate
                  //     _identityField(
                  //         fName: 'تاريخ الميلاد ', fValue: cardData.birthdate),
                  //     // birth_place
                  //     _identityField(
                  //         fName: 'محل الميلاد ', fValue: cardData.birthPlace),
                  //     //hus
                  //     cardData.hus == ""
                  //         ? SizedBox()
                  //         : _identityField(
                  //             fName: 'اسم الزوج ', fValue: cardData.hus),
                  //
                  //     // info
                  //     // _identityField(
                  //     //     fName: 'بيانات أخرى ', fValue: cardData.info),
                  //   ],
                  // ),

                  TextButton(
                    onPressed: () async {
                      //  print(changedList);
                      CardModel card = CardModel();

                      card.id = '$id-${DateTime.now()}';

                      controller.sendData(
                          cardData,
                          context,
                          nameController.text,
                          addressController.text,
                          jobController.text,
                          //genderController.text,
                          religionController.text,
                          maritalStatusController.text,
                          //birthdateController.text,
                          //birthPlaceController.text,
                          husController.text,
                          changedList);

                          
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


  Widget _getImage(String encodedImage) {
    Uint8List decodedImage = base64Decode(encodedImage);
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: MemoryImage(decodedImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
