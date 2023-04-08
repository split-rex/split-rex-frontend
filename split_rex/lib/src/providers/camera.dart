import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraProvider extends ChangeNotifier {
  List<CameraDescription>? cameras;
  late File picture;

  void setCameras(value) {
    cameras = value;
    notifyListeners();
  }

  void setPicture(file) {
    picture = file;
    notifyListeners();
  }
}

final cameraProvider = ChangeNotifierProvider((ref) => CameraProvider());
