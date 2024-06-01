import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddImageController extends GetxController {
  //instance of image picker
  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;
  final RxList<String> arrImagesUrl = <String>[].obs;
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  // Method to Show Image Picker Dialog Box
  Future<void> showImagesPickerDialog() async {
    PermissionStatus status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    if (androidDeviceInfo.version.sdkInt <= 30) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.mediaLibrary.request();
    }
    if (status == PermissionStatus.granted) {
      Get.defaultDialog(
          title: "Choose Image",
          middleText: "Pick an Image from the camera or gallery?",
          actions: [
            ElevatedButton(
                onPressed: () {
                  selectImages("camera");
                },
                child: const Text("Camera")),
            ElevatedButton(
                onPressed: () {
                  selectImages("gallery");
                },
                child: const Text("Gallery")),
          ]);
    }
    if (status == PermissionStatus.denied) {
      print(" Error please allow permission for further usage");
      openAppSettings();
    }
    if (status == PermissionStatus.permanentlyDenied) {
      print("Error please allow permission for further usage");
      openAppSettings();
    }

    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  }

  //  Method to Select images from gallery Or camera
  Future<void> selectImages(String type) async {
    List<XFile> imgs = [];
    if (type == "gallery") {
      try {
        imgs = await _picker.pickMultiImage(imageQuality: 90);
        update();
      } catch (e) {
        print("Error: $e");
      }
    } else {
      final img =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 90);
      if (img != null) {
        imgs.add(img);
        update();
      }
    }
    if (imgs.isNotEmpty) {
      selectedImages.addAll(imgs);
      update();
      print(selectedImages.length);
    }
  }

  // To remove Image
  void removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  Future<void> uploadFuction(List<XFile> _images) async {
    arrImagesUrl.clear();
    for (var i = 0; i < _images.length; i++) {
      dynamic imageUrl = await uploadFile(_images[i]);
      arrImagesUrl.add(imageUrl.toString());
    }
  }

  Future<String> uploadFile(XFile _image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child("product-images")
        .child(_image.name + DateTime.now().toString())
        .putFile(File(_image.path));
    return reference.ref.getDownloadURL();
  }
}
