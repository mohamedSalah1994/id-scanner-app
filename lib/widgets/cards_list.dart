import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:id_scanner/components/alert_dialog.dart';
import 'package:id_scanner/components/rounded_elevated_button.dart';
import 'package:id_scanner/components/show_snack_bar.dart';
import 'package:id_scanner/controllers/card_controller.dart';
import 'package:id_scanner/controllers/internet_connection_controller.dart';
import 'package:id_scanner/models/card_model.dart';

import 'package:id_scanner/screens/home.dart';

import '../app_data.dart';
import '../components/my_text.dart';
import '../models/card_data.dart';

import '../screens/scan_image.dart';

class CardsList extends StatelessWidget {
  const CardsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InternetConnectionController>(
      builder: (internetController) {
        return GetBuilder<CardController>(builder: (cardController) {
          return FutureBuilder<List>(
            future: cardController.getAllLocalCards(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Loading...'),
                      SizedBox(width: 15),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: 'لا توجد بطاقات',
                      color: AppData.secondaryFontColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 80),
                    const Icon(Icons.arrow_downward, size: 60)
                  ],
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data?.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, int i) {
                  CardModel card = CardModel.fromMap(snapshot.data![i]);
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        GridTile(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.grey.shade400, width: 2),
                                    image: DecorationImage(
                                      image: FileImage(
                                          File(card.frontImagePath.toString())),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Expanded(
                                child: RoundedElevatedButton(
                                    text: 'إرسال',
                                    onPressed: () async {
                                      await internetController
                                          .checkConnection();
                                      if (internetController.online) {
                                        cardController.isLoading = true;
                                        Map<String, dynamic> responseData =
                                            await _scanCard(card);
                                        CardData cardData =
                                            CardData.fromMap(responseData);

                                        if (responseData.isNotEmpty) {
                                          cardController.isLoading = false;
                                          Get.toNamed(ScanImage.id,
                                              arguments: cardData);
                                        } else {
                                          cardController.isLoading = false;

                                          showRecaptureSnackBar('تنبيه',
                                              'يوجد مشكله بالصوره اعد التقاط الصوره');
                                          Get.offAndToNamed(Home.id);
                                          // massage("good luck", context);
                                          //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();
<<<<<<< HEAD
=======
                                         
>>>>>>> d6f11fa26669e1a9db1b5c74f2f297b82504328d
                                        }
                                      } else {
                                        showRecaptureSnackBar(
                                            'تنبيه', 'تعذر الاتصال بالانترنت');
                                      }
                                      //else  {cardController.isLoading = false;}  by m_gomaa
                                    }),
                              ),
                              const SizedBox(height: 3),
                            ],
                          ),
                          footer: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 125),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 3),
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              '${card.id}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black54),
                            child: IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.white),
                              onPressed: () async {
                                await kAlertDialog(
                                  content: 'هل أنت متأكد من حذف البطاقه ؟',
                                  onConfirm: () async {
                                    cardController.isLoading = true;
                                    int count = await cardController
                                        .deleteLocalCard(card);
                                    cardController.isLoading = false;
                                    if (count == 1) {
                                      cardController.isLoading = false;
                                      showSuccessSnackBar(
                                        'حذف البطاقه',
                                        'تم الحذف البطاقه بنجاح',
                                      );
                                      Get.offAndToNamed(Home.id);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 50,
                        //   right: 10,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(30),
                        //         color: Colors.black54),
                        //     child: IconButton(
                        //       visualDensity: VisualDensity.compact,
                        //       icon: const Icon(Icons.edit, color: Colors.white),
                        //       onPressed: () =>
                        //           Get.toNamed(EditCard.id, arguments: card),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        });
      },
    );
  }

  Future<Map<String, dynamic>> _scanCard(CardModel card) async {
    String frontImageName = card.frontImagePath!.split('/').last;
    String backImageName = card.backImagePath!.split('/').last;
    Uri url = Uri.parse('https://41.218.156.154/reader/api');
    var request = http.MultipartRequest('POST', url);

    //============================================================
    var frontImage = _createFormFileFromStream(
        jsonKey: 'front_image',
        filePath: card.frontImagePath,
        fileName: frontImageName);
    var backImage = _createFormFileFromStream(
        jsonKey: 'back_image',
        filePath: card.backImagePath,
        fileName: backImageName);

    request.fields.addAll({
      "event": card.event.toString(),
      "user_id": card.user_id.toString(),
    });
    request.files.add(frontImage);
    request.files.add(backImage);
    // CardModel card1 = Card();
    //============================================================
    try {
      var response = await request.send();
      var responseDataAsBytes = await response.stream.toBytes();
      var responseData = json.decode(utf8.decode(responseDataAsBytes));

      if (response.statusCode == 400) {
<<<<<<< HEAD
=======
        
>>>>>>> d6f11fa26669e1a9db1b5c74f2f297b82504328d
        return {};
      } else {
        return responseData;
      }
    } catch (e) {
<<<<<<< HEAD
=======
      
>>>>>>> d6f11fa26669e1a9db1b5c74f2f297b82504328d
      return {};
    }
  }

  http.MultipartFile _createFormFileFromStream({
    required String jsonKey,
    required String? filePath,
    required String fileName,
  }) {
    return http.MultipartFile(
      jsonKey,
      File(filePath.toString()).readAsBytes().asStream(),
      File(filePath.toString()).lengthSync(),
      filename: fileName,
    );
  }
<<<<<<< HEAD
=======

>>>>>>> d6f11fa26669e1a9db1b5c74f2f297b82504328d
}
