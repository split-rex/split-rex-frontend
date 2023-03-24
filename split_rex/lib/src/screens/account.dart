import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/routes.dart';


class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context, 
      ref,
      "Account",
      "home",
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
        ),
        width: double.infinity,
        child: Column(
          children:[
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Initicon(text: ref.watch(authProvider).userData.name, size: 72),
                        const SizedBox(width: 16.0),
                        Text(ref.watch(authProvider).userData.name,
                            style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F),
                          )),
                        ],
                      ),
                      const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(95, 79, 79, 79)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Username",
                            style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F),
                          )),
                          const SizedBox(height: 4.0),
                          Text(ref.watch(authProvider).userData.username,
                            style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF4F4F4F),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Email",
                            style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F),
                          )),
                          SizedBox(height: 4.0),
                          Text("placeholder@email.com",
                            style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.red,
                          )),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(routeProvider).changePage("edit_account");
                    },
                    child: const Icon(Icons.edit),
                  )
                ]
              )
            )
          ]
        )
      ),
    );
  }
}
