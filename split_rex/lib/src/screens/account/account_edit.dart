import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/widgets/modal_color.dart';

import '../../services/auth.dart';

class EditAccount extends ConsumerStatefulWidget {
  const EditAccount({super.key});

  @override
  ConsumerState<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends ConsumerState<EditAccount> {
  final nameController = TextEditingController();

  @override
  void dispose() {
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
        child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Container(
                padding: const EdgeInsets.only(
                    top: 24, left: 4, right: 4, bottom: 24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Stack(children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                ModalColor(ref: ref),
                                const SizedBox(width: 16.0),
                                Expanded(
                                    child: TextField(
                                        key: UniqueKey(),
                                        controller: nameController,
                                        cursorColor: const Color(0xFF59C4B0),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                            filled: true,
                                            hintText: ref
                                                .watch(authProvider)
                                                .userData
                                                .name,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            suffixIcon: const Icon(Icons.edit,
                                                color: Colors.grey))))
                              ]),
                              const Divider(
                                  thickness: 1,
                                  height: 40.0,
                                  color: Color.fromARGB(95, 79, 79, 79)),
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
                                  Text(
                                      ref.watch(authProvider).userData.username,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF4F4F4F),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Email",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4F4F4F),
                                      )),
                                  const SizedBox(height: 4.0),
                                  Text(ref.watch(authProvider).userData.email,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF4F4F4F),
                                      )),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 16.0),
                      SaveButton(
                        key: UniqueKey(),
                        nameController: nameController,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        margin: const EdgeInsets.only(top: 32),
                        child: InkWell(
                            onTap: () {
                              ref
                                  .read(routeProvider)
                                  .changePage("change_password");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.lock,
                                    color: Color(0XFF2E9281), size: 16),
                                SizedBox(width: 8.0),
                                Text("Change password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(0XFF2E9281)))
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: const Color(0XFF6DC7BD),
                        ),
                        child: const Icon(Icons.format_color_fill_sharp,
                            size: 16, color: Colors.white),
                      )
                    ],
                  )
                ]))),
      ),
    );
  }
}

class SaveButton extends ConsumerWidget {
  final TextEditingController nameController;

  const SaveButton({
    required Key key,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () async {
          ref.read(authProvider).changeUserName(nameController.text == ""
              ? ref.watch(authProvider).userData.name
              : nameController.text);
          await ApiServices().updateProfile(ref);
          ref.read(routeProvider).changePage("account");
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              height: 70,
              decoration: const BoxDecoration(
                  color: Color(0xFF6DC7BD),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Changes saved!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ));
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
                child: const Text("Save Changes",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)))));
  }
}
