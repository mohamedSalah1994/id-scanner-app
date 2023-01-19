import 'package:flutter/material.dart';

class IDReport extends StatefulWidget {
  const IDReport({Key? key}) : super(key: key);
  static const String id = '/id_report';

  @override
  State<IDReport> createState() => _IDReportState();
}

class _IDReportState extends State<IDReport> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تقرير بيانات البطاقة')),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            _identityField(fName: 'الرقم القومى', fValue: '29506451278964'),
            _identityField(fName: 'تاريخ الإنتهاء', fValue: '15 / 3 / 2025'),
            _identityField(fName: 'الإسم', fValue: 'محمد عبدالله عبد عبدالواحد'),
            _identityField(fName: 'العنوان', fValue: '7 ش شوشة - الزقازيق - الشرقية'),
            _identityField(fName: 'الوظيفة', fValue: 'محامى حر'),
            _identityField(fName: 'النوع', fValue: 'ذكر'),
            _identityField(fName: 'الديانة', fValue: 'مسلم'),
            _identityField(fName: 'الحالة الإجتماعية', fValue: 'متزوج'),
            const SizedBox(height: 20),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ElevatedButton(
                child: const Text('إنهاء', style: TextStyle(fontSize: 17)),
                onPressed: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _identityField({required String fName, required String fValue}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: ListTile(
      leading: Text('$fName:', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      title: Text(fValue, style: const TextStyle(fontSize: 16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    ),
  );
}
