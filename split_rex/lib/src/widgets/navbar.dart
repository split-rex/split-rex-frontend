import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/routes.dart';


class Navbar extends ConsumerWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: const Color(0xFF4F4F4F),
    unselectedItemColor: const Color(0XFF92949C),
    currentIndex: ref.watch(routeProvider).currentNavbarIdx,
    onTap: (value) {
      ref.watch(routeProvider).changeNavbarIdx(value);
    },
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        label: 'Group'),
      BottomNavigationBarItem(
        icon: Expanded(child: Icon(Icons.add_circle, color: Color(0XFF6DC7BD), size: 35)),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.show_chart),
        label: 'Activity'),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Account'),
      ],
    );
  }
}
