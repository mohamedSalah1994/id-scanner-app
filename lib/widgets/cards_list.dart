import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:id_scanner/components/alert_dialog.dart';
import 'package:id_scanner/components/rounded_elevated_button.dart';
import 'package:id_scanner/components/show_snack_bar.dart';
import 'package:id_scanner/controllers/card_controller.dart';
import 'package:id_scanner/controllers/internet_connection_controller.dart';

import 'package:id_scanner/models/card_model.dart';

import 'package:id_scanner/widgets/internet_widget.dart';

import '../app_data.dart';
import '../components/my_text.dart';
import '../models/card_data.dart';

import '../screens/edit_card.dart';
import '../screens/home.dart';
import '../screens/loginAuth.dart';
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
                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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

              return InterNetWidget(
                widget: GridView.builder(
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
                                          color: Colors.grey.shade400,
                                          width: 2),
                                      image: DecorationImage(
                                        image: FileImage(File(
                                            card.frontImagePath.toString())),
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
                                        await _scanCard(card);

                                        //else  {cardController.isLoading = false;}  by m_gomaa
                                      }),
                                ),
                                // const SizedBox(height: 3),
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
                          Positioned(
                            bottom: 50,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black54),
                              child: IconButton(
                                visualDensity: VisualDensity.compact,
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                                onPressed: () =>
                                    Get.toNamed(EditCard.id, arguments: card),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        });
      },
    );
  }

// Function to create a form file from a file path
  Future<http.MultipartFile> _createFormFileFromStream({
    required String jsonKey,
    required String filePath,
    required String fileName,
  }) async {
    final file = File(filePath);
    return await http.MultipartFile.fromPath(jsonKey, file.path,
        filename: fileName);
  }

  Future<Map<String, dynamic>> _scanCard(CardModel card) async {
    const String url = 'https://api-ocr.egcloud.gov.eg/reader/api';
    String? tokenString =
        CacheHelper.getData(key: 'token'); // Retrieve the JSON string
    Map<String, dynamic> tokenData =
        json.decode(tokenString!); // Parse the JSON string

    String token = tokenData['token']; // Access the token value

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers['Authorization'] = 'Token $token';

    var frontImage = await _createFormFileFromStream(
      jsonKey: 'front_image',
      filePath: card.frontImagePath!,
      fileName: 'front_image.jpg',
    );

    var backImage = await _createFormFileFromStream(
      jsonKey: 'back_image',
      filePath: card.backImagePath!,
      fileName: 'back_image.jpg',
    );

    request.files.add(frontImage);
    request.files.add(backImage);

    // Set loading to true before starting the request
    final cardController = Get.find<CardController>();
    cardController.isLoading = true;

    try {
      var response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Decode response data
        Map<String, dynamic> responseDataMap =
            json.decode(utf8.decode(responseData.bodyBytes));
        CardData cardData = CardData.fromMap(responseDataMap);

        // Navigate to ScanImage with cardData
        Get.toNamed(ScanImage.id, arguments: cardData);

        return responseDataMap;
      } else {
        throw Exception('Failed to post images: ${responseData.body}');
      }
    } catch (error) {
      // Show error dialog
      showRecaptureSnackBar('تنبيه', 'يوجد مشكله بالصوره اعد التقاط الصوره');

      // Return an empty map to indicate failure
      return {};
    } finally {
      // Always set loading to false after completing the process
      cardController.isLoading = false;
    }
  }
}
