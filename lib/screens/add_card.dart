import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/components/show_snack_bar.dart';

import 'package:id_scanner/controllers/card_controller.dart';
import 'package:id_scanner/models/events_model.dart';
import 'package:id_scanner/widgets/internet_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../app_data.dart';
import '../components/custom_widgets.dart';
import '../components/input_filed_decoration.dart';
import '../components/my_text.dart';
import '../components/rounded_button.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);
  static const String id = '/add_card';

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  // EventModel? eventModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      init: CardController(),
      builder: (controller) {
        //  controller.getEvents();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: InterNetWidget(
            widget: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('إنشاء ملف البطاقة',
                    style: TextStyle(color: AppData.primaryFontColor)),
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: AppData.primaryFontColor, size: 25),
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
                progressIndicator: CircularProgressIndicator(
                  color: AppData.mainColor,
                ),
                inAsyncCall: controller.isLoading,
                child: RawScrollbar(
                  thumbColor: Colors.blue,
                  thickness: 4,
                  thumbVisibility: true,
                  // trackVisibility: true,
                  child: ListView(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 0, bottom: 5),
                    children: [
                      Form(
                        key: controller.createFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            inputLabel('النشاط'),
                            const SizedBox(height: 5),
                            controller.loading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : DropdownButtonFormField2(
                                    decoration: kAddCardInputFieldDecoration,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    iconSize: 30,
                                    buttonHeight: 50,
                                    buttonPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    dropdownDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                   
                                  ),
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
                                decoration: controller.frontImageName!.isEmpty
                                    ? const BoxDecoration()
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.frontImageFile),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                child: controller.frontImageName!.isEmpty
                                    ? Icon(Icons.image,
                                        color: AppData.placeholderColor,
                                        size: 80)
                                    : Container(),
                              ),
                            ),
                            // ValidationError(
                            //     errorMessage: 'أدخل وجه البطاقة',
                            //     visible: controller.frontImageName!.isEmpty),
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
                              onPressed: () async =>
                                  await controller.chooseCardImage(),
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
                                decoration: controller.backImageName!.isEmpty
                                    ? const BoxDecoration()
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.backImageFile),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                child: controller.backImageName!.isEmpty
                                    ? Icon(Icons.image,
                                        color: AppData.placeholderColor,
                                        size: 80)
                                    : Container(),
                              ),
                            ),
                            // ValidationError(
                            //     errorMessage: 'أدخل ظهر البطاقة',
                            //     visible: controller.backImageName!.isEmpty),
                            const SizedBox(height: 50),
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
                              onPressed: () async => await controller
                                  .chooseCardImage(isFront: false),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      RoundedButton(
                          color: AppData.mainColor,
                          child: const MyText(
                              text: 'إنشاء', color: Colors.white, fontSize: 20),
                          onPressed: () {
                            if (controller.selected == null) {
                              showWarningSnackBar(
                                'تنبيه',
                                'يجب أن تختار نشاط',
                              );
                            } else if (controller.frontImageName!.isEmpty) {
                              showWarningSnackBar(
                                'تنبيه',
                                'يجب أن تدخل وجه البطاقه',
                              );
                            } else if (controller.backImageName!.isEmpty) {
                              showWarningSnackBar(
                                'تنبيه',
                                'يجب أن تدخل ظهر البطاقه',
                              );
                            } else {
                              return controller.createCard();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
