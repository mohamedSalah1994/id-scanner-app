import 'package:flutter/material.dart';

import '../app_data.dart';

var kLoginInputFieldDecoration = const InputDecoration(
  hintText: "Email",
  hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
  prefixIcon: Icon(Icons.email, color: Colors.white, size: 20),
  border: OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
);

var kAddCardInputFieldDecoration = InputDecoration(
  filled: true,
  fillColor: AppData.textFieldFillColor,
  hintText: "اختر نشاط",
  hintStyle: TextStyle(color: AppData.placeholderColor, fontSize: 15),
  contentPadding: const EdgeInsets.only(right: 0),
  prefixIcon: const Icon(Icons.event, color: Colors.black87, size: 20),
  border: const OutlineInputBorder(
    // borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.75),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
);
