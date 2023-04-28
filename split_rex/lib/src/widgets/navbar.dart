import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/group.dart';
import 'package:camera/camera.dart';
import 'package:split_rex/src/widgets/groups/group_settings.dart';
import '../providers/camera.dart';
import '../services/scan_bill.dart';

class Navbar extends ConsumerWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4F4F4F),
        unselectedItemColor: const Color(0XFF92949C),
        currentIndex: ref.watch(routeProvider).currentNavbarIdx,
        onTap: (value) async {
          if (value == 2) {
            showDialog(
                barrierColor: Colors.transparent,
                context: context,
                builder: (BuildContext dialogContext) {
                  return const _PopupExpense();
                });
          } else {
            ref.read(routeProvider).changeNavbarIdx(context, value);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: Color(0XFF6DC7BD), size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    ]);
  }
}

class _PopupExpense extends ConsumerWidget {
  const _PopupExpense();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 80),
          child: Wrap(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(50, 0, 0, 0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: IntrinsicWidth(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Divider(
                            thickness: 0, height: 2, color: Colors.white),
                        GestureDetector(
                          onTap: () {
                            GroupServices().userGroupList(ref).then((value) {
                              Navigator.pop(context);
                              ref
                                  .read(routeProvider)
                                  .changePage(context, "/add_expense");
                            });
                          },
                          child: const Text("Manual Input"),
                        ),
                        const Divider(
                            thickness: 1, height: 24, color: Color(0XFFDCDCDC)),
                        GestureDetector(
                          onTap: () async {
                            XFile? pickedFile = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );
                            if (pickedFile != null) {
                              EasyLoading.instance
                                ..displayDuration = const Duration(seconds: 3)
                                ..indicatorType =
                                    EasyLoadingIndicatorType.fadingCircle
                                ..loadingStyle = EasyLoadingStyle.custom
                                ..indicatorSize = 45.0
                                ..radius = 16.0
                                ..textColor = Colors.white
                                ..progressColor = const Color(0xFF4F9A99)
                                ..backgroundColor = const Color(0xFF4F9A99)
                                ..indicatorColor = Colors.white
                                ..maskType = EasyLoadingMaskType.custom
                                ..maskColor =
                                    const Color.fromARGB(155, 255, 255, 255);
                              EasyLoading.show(
                                  status: 'Scanning...',
                                  maskType: EasyLoadingMaskType.custom);
                              logger.d("MASOKK1");
                              String filename =
                                  DateTime.now().toIso8601String();
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              var imagePath =
                                  await File('${directory.path}/$filename.png')
                                      .create();
                              Uint8List image = await pickedFile.readAsBytes();
                              await imagePath.writeAsBytes(image);
                              ScanBillServices()
                                  .postBill(ref, imagePath)
                                  .then((value) {
                                EasyLoading.dismiss();
                                Navigator.pop(context);
                                ref
                                    .read(routeProvider)
                                    .changePage(context, "/add_expense");
                              });
                            }
                          },
                          child: const Text(
                              "Upload from Photo Library\t\t\t\t\t\t\t\t"),
                        ),
                        const Divider(
                            thickness: 1, height: 24, color: Color(0XFFDCDCDC)),
                        GestureDetector(
                          onTap: () {
                            // take photo
                            Navigator.pop(context);
                            if (ref.watch(cameraProvider).cameras == null) {
                              availableCameras().then((value) {
                                ref.read(cameraProvider).setCameras(value);
                                ref
                                    .read(routeProvider)
                                    .changePage(context, "/scan_bill");
                              });
                            } else {
                              ref
                                  .read(routeProvider)
                                  .changePage(context, "/scan_bill");
                            }
                          },
                          child: const Text("Take Photo"),
                        ),
                        const Divider(
                            thickness: 0, height: 2, color: Colors.white)
                      ]))),
            ],
          )),
    );
  }
}
