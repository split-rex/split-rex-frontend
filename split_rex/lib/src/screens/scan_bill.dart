import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';

import '../providers/add_expense.dart';
import '../providers/camera.dart';
import '../providers/routes.dart';
import '../services/scan_bill.dart';


class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  CameraController? _cameraController;
  bool _isFlashOn = false;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void dispose() {
    log("dispose");
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    log("deactivate");
    _cameraController?.dispose();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final List<CameraDescription>? cameras = ref.watch(cameraProvider).cameras;
      initCamera(cameras![0]);
      _cameraController?.setFlashMode(FlashMode.off);
    });
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController?.initialize().then((_) {
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
    // final widthScreen = MediaQuery.of(context).size.width + 40;
    // final heightScreen = MediaQuery.of(context).size.height + 40;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _cameraController == null 
        ? const Center(
            child: CircularProgressIndicator()
          )
        :
        Stack(
          children: [
          (_cameraController!.value.isInitialized)
              ?  Center(
                  child: Screenshot(
                    controller: screenshotController,
                    child: CameraPreview(_cameraController!), 
                  )
                )
              
              : Container(
                  color: const Color.fromARGB(195, 36, 54, 53),
                  child: const Center(child: CircularProgressIndicator())),
              (_cameraController!.value.isInitialized) ?
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
                      height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.20) - 60,
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
                    const Expanded(
                      child: SizedBox(width: 30)
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () async {
                          await _cameraController!.setFlashMode(FlashMode.off);
                          await Future.delayed(const Duration(milliseconds: 400));
                          await _cameraController!.pausePreview();
                          EasyLoading.instance
                          ..displayDuration = const Duration(seconds: 3)
                          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                          ..loadingStyle = EasyLoadingStyle.custom
                          ..indicatorSize = 45.0
                          ..radius = 16.0
                          ..textColor = Colors.white
                          ..progressColor = const Color(0xFF4F9A99)
                          ..backgroundColor = const Color(0xFF4F9A99)
                          ..indicatorColor = Colors.white
                          ..maskType = EasyLoadingMaskType.custom
                          ..maskColor = const Color.fromARGB(155, 255, 255, 255);
                          EasyLoading.show(
                            status: 'Scanning...',
                            maskType: EasyLoadingMaskType.custom
                          );
                          screenshotController.capture(
                            delay: const Duration(milliseconds: 10)
                          ).then((image) async {
                            if (image != null) {
                              String filename = DateTime.now().toIso8601String();
                              final directory = await getApplicationDocumentsDirectory();
                              var imagePath = await File('${directory.path}/$filename.png').create();
                              await imagePath.writeAsBytes(image);
                              await ScanBillServices().postBill(ref, imagePath).then((value) {
                                EasyLoading.dismiss();
                                ref.read(addExpenseProvider).resetAll();
                                ref.read(routeProvider).changePage(context, "/add_expense");
                              });
                            }
                          }).catchError((onError) {
                            log(onError);
                          });
                        },
                        iconSize: 50,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.camera, color: Colors.white),
                      )
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () async {
                          if (_isFlashOn) {
                            await _cameraController!.setFlashMode(FlashMode.off);
                            setState(() {_isFlashOn = false;});
                          } else {
                            await _cameraController!.setFlashMode(FlashMode.torch);
                            setState(() {_isFlashOn = true;});
                          }
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
                  .read(routeProvider)
                  .changePage(context, "/home"),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: const Icon(Icons.navigate_before,
                      color: Colors.white, size: 36
                    )
                  
                  )
        )]
        ),
      ),
    );

  }
}

class PreviewPage extends ConsumerWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Image.file(
          //   File(picture.path), 
          //   fit: BoxFit.cover, width: 250
          // ),
          const SizedBox(height: 24),
          InkWell(
              onTap: () => ref
                .read(routeProvider)
                .changePage(context, "/home"),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: const Icon(Icons.navigate_before,
                    color: Colors.grey, size: 36)
                  ),
            )
        ]),
      ),
    );
  }
}
