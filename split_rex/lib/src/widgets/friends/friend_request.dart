import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/routes.dart';

class FriendRequestHeader extends ConsumerWidget {
  const FriendRequestHeader({super.key});

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
              "Friend Requests",
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

class FriendRequestJumbotron extends ConsumerWidget {
  const FriendRequestJumbotron({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.only(left: 28.0, right: 28.0),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // TODO: changeable received and set @samuelswandi
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Color(0xFF4F9A99),
              width: 3.0, // Underline thickness
            ))),
            child: const Text(
              "Received",
              style: TextStyle(
                  color: Color(0xFF4F9A99), fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(width: 14),
          const Text("Sent",
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.w500)),
        ]));
  }
}

class FriendRequestDetail extends StatelessWidget {
  const FriendRequestDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
      Text("Received",
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4F9A99),
              fontWeight: FontWeight.bold)),
      SizedBox(width: 10),
    ]);
  }
}

class FriendRequestBody extends ConsumerWidget {
  const FriendRequestBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.only(left: 28.0, right: 28.0),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: const [
              FriendRequestDetail(),
              FriendRequestDetail()
        ]));
  }
}
