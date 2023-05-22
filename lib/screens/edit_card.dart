import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/controllers/card_controller.dart';

import 'package:id_scanner/models/card_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../app_data.dart';
import '../components/custom_widgets.dart';
import '../components/input_filed_decoration.dart';
import '../components/my_text.dart';
import '../components/rounded_button.dart';
import '../models/events_model.dart';

class EditCard extends StatefulWidget {
  const EditCard({Key? key}) : super(key: key);
  static const String id = '/edit_card';

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  CardModel card = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('تعديل ملف البطاقة', style: TextStyle(color: AppData.primaryFontColor)),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppData.primaryFontColor, size: 25),
                onPressed: () {
                  controller.resetAttributes();
                  Get.back();
                },
              ),
              actions: [
                Container(
                  alignment: Alignment.center,
                  child: MyText(
                    text: controller.camera ? 'الكاميرا' : 'الإستوديو',
                    color: AppData.secondaryFontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 40,
                  child: FittedBox(
                    child: CupertinoSwitch(
                      value: controller.camera,
                      onChanged: (val) => controller.camera = val,
                      activeColor: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            body: ModalProgressHUD(
              inAsyncCall: controller.isLoading,
              child: RawScrollbar(
                thumbColor: Colors.blue,
                thickness: 4,
                thumbVisibility: true,
                // trackVisibility: true,
                child: ListView(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 5),
                  children: [
                    Form(
                      key: controller.editFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          inputLabel('النشاط'),
                          const SizedBox(height: 5),
                          controller.loading
                              ? const Center(child: CircularProgressIndicator())
                              : DropdownButtonFormField2(
                                  decoration: kAddCardInputFieldDecoration,
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 30,
                                  buttonHeight: 50,
                                  buttonPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  items: controller.eventObject.data
                                      .map<DropdownMenuItem<EventDatum>>(
                                          (EventDatum event) {
                                    return DropdownMenuItem<EventDatum>(
                                      value: event,
                                      child: Text(
                                        event.eventName.capitalize.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (EventDatum? newValue) {
                                    controller.selected = newValue;
                                  },
                                  
                                  onSaved: (value) {}),
                          const SizedBox(height: 20),
                          inputLabel('وجه البطاقة'),
                          const SizedBox(height: 5),
                          DottedBorder(
                            strokeWidth: 2,
                            dashPattern: const [6, 6],
                            color: AppData.placeholderColor,
                            child: Container(
                              height: 140,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    controller.frontImageName!.isNotEmpty
                                        ? controller.frontImageFile
                                        : File(card.frontImagePath.toString()),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          RoundedButton(
                            color: Colors.white,
                            child: MyText(
                              text: 'اختر صورة',
                              textStyle: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 2,
                              ),
                            ),
                            hasBorder: true,
                            onPressed: () async => await controller.chooseCardImage(),
                          ),
                          const SizedBox(height: 20),
                          inputLabel('ظهر البطاقة'),
                          const SizedBox(height: 5),
                          DottedBorder(
                            strokeWidth: 2,
                            dashPattern: const [6, 6],
                            color: AppData.placeholderColor,
                            child: Container(
                              height: 140,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    controller.backImageName!.isNotEmpty
                                        ? controller.backImageFile
                                        : File(card.backImagePath.toString()),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          RoundedButton(
                            color: Colors.white,
                            child: MyText(
                              text: 'اختر صورة',
                              textStyle: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 2,
                              ),
                            ),
                            hasBorder: true,
                            onPressed: () async => await controller.chooseCardImage(isFront: false),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    RoundedButton(
                      color: AppData.mainColor,
                      child: const MyText(text: 'حفظ التعديلات', color: Colors.white, fontSize: 18),
                      onPressed: () => controller.editCard(card),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
