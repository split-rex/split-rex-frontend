import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter/services.dart';

class SettleUpBody extends ConsumerWidget {
  const SettleUpBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Amount to settle with",
          style: TextStyle(fontSize: 16),
        ),
        const Text(
          "Lucinta Lumpia",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Initicon(
                  text: "ME", size: 79, backgroundColor: Color(0xFFFDE4DA)),
              Icon(
                Icons.arrow_right_alt_rounded,
                color: Color(0xFFC0C6C5),
                size: 50,
              ),
              Initicon(
                  text: "FRIEND", size: 79, backgroundColor: Color(0xFFC1E9FF)),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 200,
          child: TextField(
            // style: TextStyle(fontSize: 16),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
            decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixText: "Rp ",
                hintText: 'Enter amount to settle',
                hintStyle: const TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // TODO: buat if else lah pkknya owed or lent
        RichText(
          text: const TextSpan(
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              children: [
                TextSpan(text: "out of "),
                TextSpan(
                    text: "Rp",
                    style: TextStyle(
                        color: Color(0xffFF0000), fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "600.000",
                    style: TextStyle(
                        color: Color(0xffFF0000), fontWeight: FontWeight.bold)),
                TextSpan(text: " you owed"),
              ]),
        ),
        const SizedBox(height: 20),
        const SettleUpButton()
      ],
    );
  }
}

class SettleUpButton extends ConsumerWidget {
  const SettleUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var errorType = ref.watch(errorProvider).errorType;
    // var errorMsg = ref.watch(errorProvider).errorMsg;

    // if (errorType == "ERROR_CANNOT_ADD_SELF" ||
    //     errorType == "ERROR_ALREADY_FRIEND" ||
    //     errorType == "ERROR_USER_NOT_FOUND" ||
    //     errorType == "ERROR_ALREADY_REQUESTED_SENT" ||
    //     errorType == "ERROR_ALREADY_REQUESTED_RECEIVED") {
    //   return Text(errorMsg);
    // }

    return GestureDetector(
      // onTap: () async {
      //   FriendServices()
      //       .addFriend(ref, ref.watch(friendProvider).addFriend.userId);
      // },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 40,
        width: MediaQuery.of(context).size.width - 280,
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
          "Settle Up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
