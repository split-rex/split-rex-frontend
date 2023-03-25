import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';

import '../providers/camera.dart';
import '../providers/routes.dart';
import '../services/scan_bill.dart';


class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  bool _isFlashOn = false;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
    _cameraController.setFlashMode(FlashMode.off);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      XFile picture = await _cameraController.takePicture();
      ref.read(cameraProvider).setPicture(picture);
      // TODO: PETORIKU DESU
      await ScanBillServices().postBill(ref, File(ref.watch(cameraProvider).picture.path));
      ref.read(routeProvider).changePage("preview_image");
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(195, 36, 54, 53)
    ));
    var camera = _cameraController.value;
    final widthScreen = MediaQuery.of(context).size.width + 40;
    final heightScreen = MediaQuery.of(context).size.height + 40;
    
    return Scaffold(
      body: SafeArea(
      child: Stack(
        children: [
        (_cameraController.value.isInitialized)
            ? Transform.scale(
              scale: 
                (widthScreen / heightScreen) * camera.aspectRatio < 1 
                ? 1 / (widthScreen / heightScreen) * camera.aspectRatio 
                : (widthScreen / heightScreen) * camera.aspectRatio,
              child: Center(
                child: CameraPreview(_cameraController),
              )
            )
            : Container(
                color: const Color.fromARGB(195, 36, 54, 53),
                child: const Center(child: CircularProgressIndicator())),
            (_cameraController.value.isInitialized) ?
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(195, 36, 54, 53), BlendMode.srcOut
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                Align(
                  alignment: Alignment.topCenter,
                  child: 
                  Container(
                    margin: const EdgeInsets.only(top: 80),
                    height: 450,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ) : const SizedBox(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: Colors.transparent
              ),
              child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                    child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 30,
                    icon: Icon(
                        _isRearCameraSelected
                            ? Icons.switch_camera_outlined
                            : Icons.switch_camera,
                        color: Colors.white),
                    onPressed: () {
                      setState(
                          () => _isRearCameraSelected = !_isRearCameraSelected);
                      initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                    })
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: takePicture,
                      iconSize: 50,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.camera, color: Colors.white),
                    )
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        await _cameraController.setFlashMode(_isFlashOn ? FlashMode.off : FlashMode.always);
                        setState(
                          () => _isFlashOn = !_isFlashOn);
                      },
                      iconSize: 30,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(_isFlashOn ? Icons.flash_off : Icons.flash_on, color: Colors.white),
                    )
                  ),
                ]
              ),
            )),
            InkWell(
              onTap: () => ref
                .watch(routeProvider)
                .changePage("home"),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: const Icon(Icons.navigate_before,
                    color: Colors.white, size: 36)
                  ),
            )
        ]
      ),)
    );
  }
}

class PreviewPage extends ConsumerWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(
            File(picture.path), 
            fit: BoxFit.cover, width: 250
          ),
          const SizedBox(height: 24),
          Text(picture.name),
          InkWell(
              onTap: () => ref
                .watch(routeProvider)
                .changePage("home"),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: const Icon(Icons.navigate_before,
                    color: Colors.grey, size: 36)
                  ),
            )
        ]),
      );
  }
}
