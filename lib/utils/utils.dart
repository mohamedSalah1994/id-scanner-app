import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as IMG;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:image/image.dart';
class Utils {
  static Future<File?> pickMedia({
    required bool isCamera,
    Future<File?> Function(File file)? cropImage,
  }) async {
    // File? compressedImage;
    final source = isCamera ? ImageSource.camera : ImageSource.gallery;
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return File('');

    if (cropImage == null) {
      // compressedImage = await compressImage(pickedFile.path);
      return File(pickedFile.path);
    } else {
      final croppedImage = await cropImage(File(pickedFile.path));
      // compressedImage = await compressImage(croppedImage!.path);
      // await getImageSize(croppedImage);
      // final resizedImage = await resizeImage(await croppedImage!.readAsBytes(), 1012, 638);
      // await getImageSize(resizedImage);
      return croppedImage;
    }
  }

  static Future<void> getImageSize(File? image) async {
    print('======================');
    var decodedImage = await decodeImageFromList(image!.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);
    print('======================');
  }

  static Future<File?> resizeImage(Uint8List data, int targetWidth, int targetHeight) async {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: targetWidth, height: targetHeight);
    resizedData = IMG.encodeJpg(resized) as Uint8List?;

    final tempDir = await getTemporaryDirectory();
    File resizedImage = await File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg').create();
    resizedImage.writeAsBytesSync(resizedData!);

    return resizedImage;
  }

  // static Future<File?> compressImage(String path) async {
  //   String targetPath = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');
  //   var result = await FlutterImageCompress.compressAndGetFile(path, targetPath, quality: 35);
  //   String targetPath2 = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');
  //   result = await FlutterImageCompress.compressAndGetFile(result!.path, targetPath2, quality: 35);
  //   String targetPath3 = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');
  //   result = await FlutterImageCompress.compressAndGetFile(result!.path, targetPath3, quality: 35);
  //   String targetPath4 = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');
  //   result = await FlutterImageCompress.compressAndGetFile(result!.path, targetPath4, quality: 35);
  //   String targetPath5 = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');
  //   result = await FlutterImageCompress.compressAndGetFile(result!.path, targetPath5, quality: 35);
  //   return result;
  // }

}
