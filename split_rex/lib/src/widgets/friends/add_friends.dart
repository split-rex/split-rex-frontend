import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/routes.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class AddFriendHeader extends ConsumerWidget {
  const AddFriendHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.only(top: 55.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ref.watch(routeProvider).changePage("home");
              },
            ),
            const Text(
              "Add Friends",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ));
  }
}

class AddFriendSearchSection extends StatefulWidget {
  const AddFriendSearchSection({super.key});
  @override
  _AddFriendSearchSection createState() => new _AddFriendSearchSection();
}

class _AddFriendSearchSection extends State<AddFriendSearchSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Search by email, name, or username',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Icon(Icons.search, color: Colors.grey),
                        width: 18,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FriendsSearched extends StatefulWidget {
  const FriendsSearched({super.key});
  @override
  _FriendsSearched createState() => new _FriendsSearched();
}

class _FriendsSearched extends State<FriendsSearched> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children:  [
          // TODO: save the color!!!
          Initicon(text: "Francesco Parrino", size:114, backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
          const SizedBox(height: 10),
          const Text("Francesco Parrino",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4F4F4F))),
          const AddBtn()
        ],
      ),
    );
  }
}

class AddBtn extends ConsumerWidget {
  const AddBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        // Write Click Listener Code Here.
        // ApiServices().searchFriend(ref);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 36,
        width: 88,
        decoration: BoxDecoration(
          color: const Color(0xFF6DC7BD),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: const Text(
          "Add",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
