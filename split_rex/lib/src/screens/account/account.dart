import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/common/logger.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/routes.dart';

import '../../common/functions.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context,
      ref,
      "Account",
      "home",
      SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(),
            width: double.infinity,
            child: Column(children: [
              Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Stack(alignment: Alignment.topRight, children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Initicon(
                              text: ref.watch(authProvider).userData.name,
                              size: 72,
                              backgroundColor: getProfileBgColor(
                                  ref.watch(authProvider).userData.color),
                              style: TextStyle(
                                  color: getProfileTextColor(
                                      ref.watch(authProvider).userData.color)),
                            ),
                            const SizedBox(width: 16.0),
                            Text(ref.watch(authProvider).userData.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4F4F4F),
                                )),
                          ],
                        ),
                        const Divider(
                            thickness: 1,
                            height: 40.0,
                            color: Color(0xFFE1F3F2)),
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
                      child: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    )
                  ])),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Payment Info",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(
                        thickness: 1, height: 40.0, color: Color(0xFFE1F3F2)),
                    Container(
                      padding: const EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height - 548,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: ref
                            .watch(authProvider)
                            .userData
                            .flattenPaymentInfo
                            .length,
                        itemBuilder: (context, index) {
                          var curr = ref
                              .watch(authProvider)
                              .userData
                              .flattenPaymentInfo[index];
                          return PaymentInfoDetail(curr[0], curr[1], curr[2]);
                        },
                        separatorBuilder: (context, index) => const Divider(
                          height: 5,
                          thickness: 0,
                        ),
                      ),
                    ),
                    AddNewPaymentInfoButton()
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}

class PaymentInfoDetail extends ConsumerWidget {
  const PaymentInfoDetail(
      this.paymentMethod, this.accountNumber, this.accountName,
      {super.key});

  final String paymentMethod;
  final String accountNumber;
  final String accountName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => deletePaymentInfoDialog(context),
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Color(0xff2E9281),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 210.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(paymentMethod,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("$accountNumber - $accountName"),
              ],
            ),
          ),
          TextButton(
              onPressed: () => editPaymentInfoDialog(context),
              child: const Text(
                "Edit",
                style: TextStyle(color: Color(0xff2E9281)),
              )),
        ],
      ),
    );
  }
}

class AddNewPaymentInfoButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () => addNewPaymentInfoDialog(context),
        child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Color(0XFF6DC7BD),
            ),
            child: const Text("Add New Payment Info",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700))));
  }
}

// ---------------------------- ADD NEW PAYMENT INFO ----------------------------
// Add new payment info modal
addNewPaymentInfoDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Text("Add Payment Info",
                  style: TextStyle(
                      color: Color(0xff2E9281),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            const AddPaymentInfoForm()
          ],
        ),
      ),
    ),
  );
}

class AddPaymentInfoForm extends ConsumerWidget {
  const AddPaymentInfoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropDownBankName()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Account Name",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // TODO: textfield
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Account Number",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // TODO: textfield
            ],
          ),
          AddPaymentInfoButton()
        ],
      ),
    );
  }
}

class AddPaymentInfoButton extends ConsumerWidget {
  const AddPaymentInfoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () => {},
        child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Color(0XFF6DC7BD),
            ),
            child: const Text("Add Payment Info",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700))));
  }
}

class DropDownBankName extends ConsumerWidget {
  // Initial Selected Value
  String dropdownvalue = 'Payment Method';

  // List of items in our dropdown menu
  var items = [
    'Payment Method',
    'OVO',
    'Gopay',
    'Lucinta Luna',
    'Bank Abank Bank Abank bank abank ',
  ];

  DropDownBankName({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: MediaQuery.of(context).size.width - 250,
        decoration: BoxDecoration(
          color: const Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton(
              isExpanded: true,
              itemHeight: null,
              style: const TextStyle(fontSize: 12, color: Colors.black),

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Initial Value
              value: dropdownvalue,

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(items),
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                // setState(() {
                //   dropdownvalue = newValue!;
                // });
              },
            )));
  }
}

// ---------------------------- EDIT PAYMENT INFO ----------------------------
// edit modal --> same as add new payment detail modal
editPaymentInfoDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Text("Edit Payment Info",
                  style: TextStyle(
                      color: Color(0xff2E9281),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            const EditPaymentInfoForm()
          ],
        ),
      ),
    ),
  );
}

class EditPaymentInfoForm extends ConsumerWidget {
  const EditPaymentInfoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                "Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // TODO: textfield
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Account Name",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // TODO: textfield
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Account Number",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // TODO: textfield
            ],
          ),
          const EditPaymentInfoButton()
        ],
      ),
    );
  }
}

class EditPaymentInfoButton extends ConsumerWidget {
  const EditPaymentInfoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () => {},
        child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Color(0XFF6DC7BD),
            ),
            child: const Text("Edit Payment Info",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700))));
  }
}

// ---------------------------- DELETE PAYMENT INFO ----------------------------
deletePaymentInfoDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            const Text(
              'Are you sure you want to delete this following payment info: ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'BCA',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Fifiimut - 132376232324',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 140,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDFF2F0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2E9281),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                // onTap: () async {
                //   await FriendServices().acceptFriendRequest(ref, userId);
                // },
                child: Container(
                  alignment: Alignment.center,
                  width: 140,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6DC7BD),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    ),
  );
}

// TODO : move it to group
// friend payment info modal
friendInfoDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            Row(
              children: [
                const Initicon(
                  text: "Nama Orangnya",
                  size: 57,
                  backgroundColor: Colors.black,
                  // backgroundColor: getProfileBgColor(memberList[1].color),
                  // style: TextStyle(color: getProfileTextColor(memberList[1].color)),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // TODO: handle overflow
                    Text("Fifi Purnama",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("Fifiimutt", style: TextStyle(fontSize: 14))
                  ],
                )
              ],
            ),
            const Divider(thickness: 1, height: 30.0, color: Color(0xFFE1F3F2)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Payment Info",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                FriendPaymentInfoDetail(),
                FriendPaymentInfoDetail()
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ),
  );
}

class FriendPaymentInfoDetail extends ConsumerWidget {
  const FriendPaymentInfoDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("BCA",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            Text("1234124213 a.n. Fifi Kurang Imut W",
                style: TextStyle(fontSize: 14))
          ],
        ));
  }
}

// TODO : ini modal sem yang confirm/deny settle
confirmOrDenyPayment(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  style: TextStyle(
                      color: Color(0xFF4F4F4F),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(text: "Confirm "),
                    TextSpan(
                        text: "Lucinta Lumpia",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "'s payment "),
                    TextSpan(
                        text: "Rp",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "600.000 ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "from group "),
                    TextSpan(
                        text: "lalala",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
            ),
            const SizedBox(height: 20),
            Initicon(
              text: "Nama Orangnya",
              size: 80,
              backgroundColor: Colors.black,
              // backgroundColor: getProfileBgColor(memberList[1].color),
              // style: TextStyle(color: getProfileTextColor(memberList[1].color)),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 140,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDFF2F0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2E9281),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                // onTap: () async {
                //   await FriendServices().acceptFriendRequest(ref, userId);
                // },
                child: Container(
                  alignment: Alignment.center,
                  width: 140,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6DC7BD),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ),
  );
}
