import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_creator/main.dart';

class ImageService {
  static Future<File?> captureImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  static Future<File?> selectImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  static Future<File?> cropImage(File pickedImage) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor: kPrimaryColor,
          statusBarColor: kPrimaryColor,
          cropFrameStrokeWidth: 5,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedImage != null) {
      return File(croppedImage.path);
    } else {
      return null;
    }
  }
}
