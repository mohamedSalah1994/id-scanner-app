import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:id_scanner/components/rounded_button.dart';

import '../controllers/login_controller.dart';

class DynamicFrom extends StatefulWidget {
  const DynamicFrom({Key? key}) : super(key: key);
  static const String id = '/dynamic_form';

  @override
  _DynamicFromState createState() => _DynamicFromState();
}

class _DynamicFromState extends State<DynamicFrom> {
  List selectData = List<String>.empty(growable: true);
  List radioData = List<String>.empty(growable: true);
  final Map<String, String> _mySelectValues = {};
  final Map<String, int> _myRadioValuesIds = {};
  final Map<String, String> _myRadioValues = {};
  final Map<String, String> _myFieldsValues = {};

//dynamic row
  _row(int index, name, fieldType, id, fieldData) {
    fieldType == "select" ? selectData = fieldData : selectData;
    fieldType == "radio" ? radioData = fieldData : radioData;

    if (fieldType == "select") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: InputDecorator(
          decoration: inputDecoration(name, fieldType),
          child: Center(
            child: DropdownButton(
              autofocus: true,
              hint: Text("Select " + name),
              value: _mySelectValues[id],
              items: selectData.map((t) {
                return DropdownMenuItem(
                  child: Text(t["text"],
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  value: t["value"],
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() => _mySelectValues[id] = newVal.toString());
              },
            ),
          ),
        ),
      );
    } else if (fieldType == "radio") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: InputDecorator(
          decoration: inputDecoration(name, fieldType),
          child: Column(
            children: radioData.map((data) {
              var index = radioData.indexOf(data);
              return RadioListTile(
                title: Text(
                  "${data["text"]}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                groupValue: index,
                activeColor: Colors.lightBlue,
                autofocus: true,
                value: _myRadioValuesIds[id] ?? -1,
                onChanged: (val) {
                  setState(() => _myRadioValuesIds[id] = index);
                  setState(() => _myRadioValues[id] = data['value']);
                },
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: TextFormField(
          keyboardType: getKeyboardType(fieldType),
          decoration: inputDecoration(name, fieldType),
          onChanged: (val) {
            _myFieldsValues[id] = val;
          },
        ),
      );
    }
  }

  InputDecoration inputDecoration(String name, String fieldType) {
    Get.put(LoginController());

    return InputDecoration(
      hintText: getHintText(fieldType),
      fillColor: Colors.white,
      filled: true,
      label: Text(name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  String getHintText(String fieldType) {
    switch (fieldType) {
      case 'email':
        return 'john@example.com';
      case 'number':
        return '';
      case 'phone':
        return '(+2)01525569748';
      case 'date':
        return '15/6/2022';
      default:
        return '';
    }
  }

  TextInputType getKeyboardType(String fieldType) {
    switch (fieldType) {
      case 'email':
        return TextInputType.emailAddress;
      case 'number':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      case 'date':
        return TextInputType.datetime;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString("assets/form_fields.json"),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Text('Error in loading form data.');
            }
            if (snapshot.data != null) {
              final jsonResult = jsonDecode(snapshot.data);
              if (jsonResult.isEmpty) {
                return const Text('There is no data for the form.');
              }
              return Container(
                color: Colors.grey.shade50,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  children: [
                    Image.asset('images/misr_rakamiya.png'),
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: jsonResult.length,
                      itemBuilder: (context, i) {
                        return _row(
                          i,
                          jsonResult[i]["name"],
                          jsonResult[i]["type"],
                          jsonResult[i]["id"],
                          jsonResult[i]["options"],
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    RoundedButton(
                      child: const Text(
                        'حفظ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      hasBorder: true,
                      color: Colors.lightGreen,
                      onPressed: () {

                      },
                    ),
                    const SizedBox(height: 40),
                    GetBuilder<LoginController>(
                      builder: (controller) {
                        return RoundedButton(
                          child: const Text(
                            'تسجيل الخروج',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          hasBorder: false,
                          color: Colors.red,
                          onPressed: () {
                            controller.sendLogOut(context);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
