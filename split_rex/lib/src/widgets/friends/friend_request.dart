import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/routes.dart';

class FriendRequestsHeader extends ConsumerWidget {
  const FriendRequestsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 1,
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.watch(routeProvider).changePage("home");
                },
                color: const Color(0xFF4F4F4F),
              ),
              const Center(
                widthFactor: 2,
                child: Text(
                  "Friend Requests",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class FriendRequestSelector extends ConsumerWidget {
  const FriendRequestSelector({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 1,
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.watch(routeProvider).changePage("home");
                },
                color: const Color(0xFF4F4F4F),
              ),
              const Center(
                widthFactor: 2,
                child: Text(
                  "Friend Requests",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class FriendRequestSectionPicker extends ConsumerWidget {
  const FriendRequestSectionPicker({super.key});

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
                fontSize: 17,
                  color: Color(0xFF4F9A99), fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(width: 14),
          const Text("Sent",
              style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.w500)),
        ]));
  }
}

class FriendRequestsBody extends ConsumerWidget {
  const FriendRequestsBody({super.key});

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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              FriendRequestDetail(),
              Divider(
                height: 10,
                thickness: 1,
                indent: 20,
                color: Color(0xFFE1F3F2),
              ),
              FriendRequestDetail(),
              Divider(
                height: 10,
                thickness: 1,
                indent: 20,
                color: Color(0xFFE1F3F2),
              ),
              FriendRequestDetail(),
            ]));
  }
}

class FriendRequestDetail extends StatefulWidget {
  const FriendRequestDetail({super.key});

  @override
  State<FriendRequestDetail> createState() => _FriendRequestDetail();
}

class _FriendRequestDetail extends State<FriendRequestDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFffffff),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Initicon(text: "Paulo Dybala"),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Paulo Dybala",
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Color(0xFF4F4F4F),
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 8.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFDFF2F0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: const Text(
                        "Reject",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E9281),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 8.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF6DC7BD),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: const Text(
                        "Accept",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            )
          ]),
    );
  }
}
