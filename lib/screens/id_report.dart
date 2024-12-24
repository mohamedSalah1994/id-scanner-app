import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../models/card_data.dart';

class IDReport extends StatefulWidget {
  const IDReport({Key? key}) : super(key: key);
  static const String id = '/id_report';

  @override
  State<IDReport> createState() => _IDReportState();
}

class _IDReportState extends State<IDReport> {
  late final CardData cardData;
  late final Map<String, String> updatedData;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    cardData = arguments['cardData'];
    updatedData = arguments['updatedData'];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تقرير بيانات البطاقة'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            _identityField(
                fName: 'الرقم القومى', fValue: '${cardData.nationalId}'),
            _identityField(
                fName: 'الإسم',
                fValue: updatedData['name'] ?? cardData.name ?? ''),
            _identityField(
                fName: 'العنوان',
                fValue: updatedData['address'] ?? cardData.address ?? ''),
            _identityField(
                fName: 'الوظيفة',
                fValue: updatedData['job'] ?? cardData.job ?? ''),
            _identityField(fName: 'النوع', fValue: cardData.gender ?? ''),
            _identityField(
                fName: 'الديانة',
                fValue: updatedData['religion'] ?? cardData.religion ?? ''),
            _identityField(
                fName: 'الحالة الإجتماعية',
                fValue: updatedData['maritalStatus'] ??
                    cardData.maritalStatus ??
                    ''),
            _identityField(
                fName: 'تاريخ الميلاد', fValue: cardData.birthdate ?? ''),
            _identityField(
                fName: 'محل الميلاد', fValue: cardData.birthPlace ?? ''),
            if (updatedData['hus'] != null && updatedData['hus']!.isNotEmpty)
              _identityField(fName: 'اسم الزوج', fValue: updatedData['hus']!),
            const SizedBox(height: 20),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .black, // Set the button's background color to black
                ),
                child: const Text('إنهاء', style: TextStyle(fontSize: 17)),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _identityField({required String fName, required String fValue}) {
  return ListTile(
    leading: Text('$fName:',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    title: Text(fValue, style: const TextStyle(fontSize: 16)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
  );
}
