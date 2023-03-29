import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/group.dart';
import 'package:camera/camera.dart';

import '../providers/auth.dart';
import '../providers/camera.dart';


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
            if (value == 0) {
              if (ref.watch(groupListProvider).isOwed) {
                await GroupServices().getGroupOwed(ref.watch(authProvider).jwtToken);
              } else {
                await GroupServices().getGroupLent(ref.watch(authProvider).jwtToken);
              }
            }
            if (value == 1)  {
              await GroupServices().userGroupList(ref);
            }
            ref.read(routeProvider).changeNavbarIdx(value);
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
                          onTap: () async {
                            await GroupServices().userGroupList(ref);
                            ref.read(routeProvider).changePage("add_expense");
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                          child: const Text("Manual Input"),
                        ),
                        const Divider(
                            thickness: 1, height: 24, color: Color(0XFFDCDCDC)),
                        GestureDetector(
                          onTap: () {
                            // upload photo from library
                            Navigator.pop(context);
                          },
                          child: const Text(
                              "Upload from Photo Library\t\t\t\t\t\t\t\t"),
                        ),
                        const Divider(
                            thickness: 1, height: 24, color: Color(0XFFDCDCDC)),
                        GestureDetector(
                          onTap: () async {
                            // take photo
                            if (ref.watch(cameraProvider).cameras == null) {
                              await availableCameras().then((value) {
                                ref.read(cameraProvider).setCameras(value);
                              });
                            }
                            ref.read(routeProvider).changePage("scan_bill");
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
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
