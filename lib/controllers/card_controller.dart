import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_identifier/flutter_device_identifier.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:id_scanner/enums/event_enum.dart';
import 'package:id_scanner/models/card_model.dart';
import 'package:id_scanner/utils/shared_variable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';

import '../components/show_snack_bar.dart';
import '../models/card_data.dart';
import '../models/events_model.dart';
import '../screens/home.dart';
import '../utils/db_helper.dart';
import '../utils/utils.dart';
import 'location_controller.dart';
import 'package:http/http.dart' as http;

class CardController extends GetxController {
  DBHelper dbHelper = DBHelper();

  late EventModel eventObject;
  @override
  void onInit() {
    getEvents();
    super.onInit();
  }

  @override
  void onReady() {
    getEvents();
    super.onReady();
  }

  // Loading Indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newValue) {
    _isLoading = newValue;
    update();
  }

  // Camera Indicator
  bool _camera = true;
  bool get camera => _camera;
  set camera(bool newValue) {
    _camera = newValue;
    update();
  }

  Event? event;
  final createFormKey = GlobalKey<FormState>();
  final editFormKey = GlobalKey<FormState>();
  Rx<String>? _frontImageName = ''.obs;
  String? get frontImageName => _frontImageName!.value;
  Rx<String>? _backImageName = ''.obs;
  String? get backImageName => _backImageName!.value;

  Rx<File>? _frontImageFile;
  File get frontImageFile => _frontImageFile!.value;
  Rx<File>? _backImageFile;
  File get backImageFile => _backImageFile!.value;
  LocationController location = LocationController();

  void resetAttributes() {
    event = null;
    _frontImageFile = _backImageFile = null;
    _frontImageName = _backImageName = ''.obs;
  }

  Future<List> getAllLocalCards() async {
    return await dbHelper.allCards();
  }

  Future<int> deleteLocalCard(CardModel card) async {
    _deleteFile(File(card.frontImagePath.toString()));
    _deleteFile(File(card.backImagePath.toString()));

    return await dbHelper.deleteCard(card.id.toString());
  }

  Future<void> _deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      //
    }
  }

  // Create New Card
  Future<void> createCard() async {
    var formData = createFormKey.currentState;
    if (formData!.validate() &&
        _frontImageName!.isNotEmpty &&
        _backImageName!.isNotEmpty) {
      formData.save();
      isLoading = true;
      String extStoragePath =
          await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DCIM + '/ID Scanner');
      var currentPosition = await location.getCurrentLocation();
      var data = jsonDecode(token.toString());
      var user_id = data['id'];

      if (currentPosition != null) {
        CardModel card = CardModel();

        card.id = '$user_id-${DateTime.now()}';
        card.event = selected!.eventId;
        card.user_id = user_id;
        card.frontImagePath = '$extStoragePath/$frontImageName';
        card.backImagePath = '$extStoragePath/$backImageName';
        card.lat = currentPosition.latitude;
        card.long = currentPosition.longitude;
        card.userAddress = await location.getCurrentAddress();
        card.deviceSerialNumber = await getSerialNumber();

        await dbHelper.addCard(card);

        isLoading = false;
        showSuccessSnackBar(
          'انشاء ملف البطاقه',
          'تم انشاء ملف البطاقه بنجاح',
        );
        Get.offAllNamed(Home.id);
        resetAttributes();
      } else {
        isLoading = false;
        showLocationAlertSnackBar('Open Location Service.');
      }
    }
  }

  // Create New Card
  Future<void> editCard(CardModel card) async {
    var formData = editFormKey.currentState;
    if (formData!.validate()) {
      formData.save();
      isLoading = true;
      String extStoragePath =
          await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DCIM + '/ID Scanner');
      var currentPosition = await location.getCurrentLocation();

      if (currentPosition != null) {
        if (event != null) card.event = event?.name;
        if (_frontImageName!.isNotEmpty) {
          _deleteFile(File(card.frontImagePath.toString()));
          card.frontImagePath = '$extStoragePath/$frontImageName';
        }
        if (_backImageName!.isNotEmpty) {
          _deleteFile(File(card.backImagePath.toString()));
          card.backImagePath = '$extStoragePath/$backImageName';
        }
        card.lat = currentPosition.latitude;
        card.long = currentPosition.longitude;
        card.userAddress = await location.getCurrentAddress();
        card.deviceSerialNumber = await getSerialNumber();
        await dbHelper.updateCard(card);

        isLoading = false;

                showSuccessSnackBar(
          'تعديل ملف البطاقه',
          'تم تعديل ملف البطاقه بنجاح',
        );
         Get.offAllNamed(Home.id);
        resetAttributes();
      } else {
        isLoading = false;
        showLocationAlertSnackBar('Open Location Service.');
      }
    }
  }

  // picking card image
  Future chooseCardImage({bool isFront = true}) async {
    final file = await Utils.pickMedia(isCamera: camera, cropImage: cropImage);
    // final file = await Utils.pickMedia(isCamera: camera);
    if (file == null || file == File('') || file.path == '') return;

    // /storage/emulated/0/DCIM/ID Scanner/
    String fileExtension = extension(file.path);
    String dir = dirname(file.path);
    int now = DateTime.now().millisecondsSinceEpoch;
    String newName;

    if (isFront) {
      _frontImageName = Rx('front-$now$fileExtension');
      newName = join(dir, frontImageName);
      _frontImageFile = Rx(file);
    } else {
      _backImageName = Rx('back-$now$fileExtension');
      newName = join(dir, backImageName);
      _backImageFile = Rx(file);
    }

    File tempFile = await file.copy(newName);

    /// save image to gallery
    await GallerySaver.saveImage(tempFile.path,
        albumName: 'ID Scanner', toDcim: true);
    update();
  }

  Future<String?> getSerialNumber() async {
    try {
      // true if the permission is already granted
      bool isPermissionAllowed =
          await FlutterDeviceIdentifier.checkPermission();
      if (!isPermissionAllowed) {
        isPermissionAllowed = await FlutterDeviceIdentifier.requestPermission();
      }
      String? serial = await FlutterDeviceIdentifier.serialCode;
      return serial;
    } catch (e) {
      return null;
    }
  }

  Future<File?> cropImage(File imageFile) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
      compressQuality: 99,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: androidUiSettingsLocked(),
      cropStyle: CropStyle.rectangle,
    );
  }

  AndroidUiSettings androidUiSettingsLocked() {
    return const AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: Colors.red,
      toolbarWidgetColor: Colors.white,
      hideBottomControls: false,
      lockAspectRatio: false,
    );
  }

  Future<Map<String, dynamic>> sendData(
      CardData card,
      BuildContext context,
      String name,
      String address,
      String job,
      // String gender,
      String religion,
      String maritalStatus,
      // String birthdate,
      // String birthPlace,
      String hus,
      List changedList) async {
    Uri url = Uri.parse('https://41.218.156.154/reader/save');
    var request = http.MultipartRequest('POST', url);

    Map<String, String> data = {
      "national_id": card.nationalId.toString(),
      "name": name,
      "address": address,
      "job": job,
      "gender": card.gender.toString(),
      "religion": religion,
      "marital_status": maritalStatus,
      "birthdate": card.birthdate.toString(),
      "birth_place": card.birthPlace.toString(),
      "hus": hus,
      "date": card.address!,
      "list": changedList.toString()
    };
    request.fields.addAll(data);

    //============================================================
    //============================================================
    try {
      var response = await request.send();
      var responseDataAsBytes = await response.stream.toBytes();
      var responseData = json.decode(utf8.decode(responseDataAsBytes));

      showSuccessSnackBar('حفظ البيانات', responseData);
      Get.offAllNamed(Home.id);
      return responseData;
    } catch (e) {
      return {};
    }
  }

  bool loading = true;
  // List<DDatum> dropDownLIst = [];
  // DDatum? dropDownSelectedValue;
  void changeState(bool state) {
    loading = state;
    update();
  }

  EventDatum? selected;

  getEvents() async {
    try {
      // changeState(true);

      http.Response response = await http.get(
        Uri.tryParse('https://41.218.156.154/reader/getevents')!,
      );
      if (response.statusCode == 200) {
        changeState(false);

        ///data successfully
        var data = utf8.decode(response.bodyBytes);
        var result = jsonDecode(data);
        eventObject = EventModel.fromJson(result);
        print(data);

        ///error
      }
    } catch (e) {
      log('Error while getting data is $e');
    } finally {
      // changeState(false);
    }
  }
}

void messageAlert(String m, BuildContext context) {
  var snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: '',
      message: m,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
// To parse this JSON data, do
//
//     final dropDownLIstModel = dropDownLIstModelFromJson(jsonString);

DropDownLIstModel dropDownLIstModelFromJson(String str) =>
    DropDownLIstModel.fromJson(json.decode(str));

String dropDownLIstModelToJson(DropDownLIstModel data) =>
    json.encode(data.toJson());

class DropDownLIstModel {
  DropDownLIstModel({
    required this.status,
    required this.data,
  });

  String status;
  List<DDatum> data;

  factory DropDownLIstModel.fromJson(Map<String, dynamic> json) =>
      DropDownLIstModel(
        status: json["status"],
        data: List<DDatum>.from(json["data"].map((x) => DDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DDatum {
  DDatum({
    required this.eventId,
    required this.eventName,
  });

  String eventId;
  String eventName;

  factory DDatum.fromJson(Map<String, dynamic> json) => DDatum(
        eventId: json["event_id"],
        eventName: json["event_name"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "event_name": eventName,
      };
}
