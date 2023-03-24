import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/widgets/auth.dart';
import 'package:split_rex/src/widgets/modal_color.dart';

import '../services/auth.dart';

class EditAccount extends ConsumerStatefulWidget {
  const EditAccount({super.key});

  @override
  ConsumerState<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends ConsumerState<EditAccount> {
  final confpassController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    confpassController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return header(
      context, 
      ref,
      "Edit Account",
      "account",
      SingleChildScrollView(
        child: 
      Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Container(
            padding: const EdgeInsets.only(top: 24, left: 4, right: 4, bottom: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0))
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container (
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            ModalColor(ref: ref),
                            const SizedBox(width: 16.0),
                            Expanded(child: 
                              TextField(
                                key: UniqueKey(),
                                controller: nameController,
                                cursorColor: const Color(0xFF59C4B0),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  hintText: ref.watch(authProvider).userData.name,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                )
                              )
                            )
                          ]),
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
                      )
                    ),
                    const SizedBox(height: 16.0),
                    PasswordField(
                      key: UniqueKey(),
                      controller: passController,
                      placeholderText: "Password"
                    ),
                    PasswordField(
                      key: UniqueKey(),
                      controller: confpassController,
                      placeholderText: "Confirm Password"
                    ),
                    SaveButton(
                      key: UniqueKey(), 
                      nameController: nameController,
                      passController: passController, 
                      confPassController: confpassController
                    ),
                  ],
                ),
                Row(children: [
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0XFF6DC7BD),
                    ),
                    child: const Icon(Icons.format_color_fill_sharp, size: 16, color: Colors.white),
                  )
                ],)
              ]
            ))
          ),
        ),
      );
  }
}

class SaveButton extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController passController;
  final TextEditingController confPassController;

  const SaveButton({
    required Key key,
    required this.nameController,
    required this.passController,
    required this.confPassController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
    onTap: () async {
      ref.read(authProvider).changeUserConfPass(confPassController.text);
      ref.read(authProvider).changeUserPass(passController.text);
      ref.read(authProvider).changeUserName(
        nameController.text == "" 
        ? ref.watch(authProvider).userData.name 
        : nameController.text
      );
      await ApiServices().updateProfile(ref);
      ref.watch(routeProvider).changePage("account");
    },
    child: Container(
      margin: const EdgeInsets.all(20),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Color(0XFF6DC7BD),
          ),
          child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
        )
      )
    );
  }
}