import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/bubble_member.dart';
import 'package:split_rex/src/common/functions.dart';

import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/group.dart';


Widget searchBar(BuildContext context, WidgetRef ref) => Container(
    width: MediaQuery.of(context).size.width - 40.0,
    margin: const EdgeInsets.only(top: 17),
    decoration: BoxDecoration(
      color: const Color(0XFFFFFFFF),
      border: Border.all(
          color: const Color.fromARGB(50, 154, 154, 176), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(14.0)),
    ),
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: TextField(
      onChanged: (text) {
        ref.read(groupListProvider).searchGroupName(text);
      },
      decoration: const InputDecoration(
        icon: Icon(
          Icons.search,
          color: Color(0XFF9A9AB0),
        ),
        suffix: InkWell(
          child: Icon(
            Icons.filter_alt,
            color: Colors.grey,
          ),
        ),
        hintText: "Search for a group....",
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    )

    // Row(
    //   children: const [
    //     Icon(
    //       Icons.search,
    //       color: Color(0XFF9A9AB0),
    //     ),
    //     SizedBox(width: 8.0),
    //     Text("Search for a group...",
    //         style: TextStyle(color: Color(0XFF9A9AB0)))
    //   ],
    // ),

    );

Widget showGroups(BuildContext context, WidgetRef ref) {
  return SizedBox(
      width: MediaQuery.of(context).size.width - 40.0,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          // shrinkWrap: true,
          // padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: ref.watch(groupListProvider).groups.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                key: ValueKey(
                    ref.watch(groupListProvider).groups[index].groupId),
                child: InkWell(
                  onTap: () async {
                    var currGroup = ref.watch(groupListProvider).groups[index];
                    ref.read(groupListProvider).changeCurrGroup(currGroup);
                    ref.read(routeProvider).changePage("group_detail");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => GroupDetail(
                    //           group:
                    //               ref.watch(groupListProvider).groups[index]),
                    //     ));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ref.watch(groupListProvider).groups[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                convertDate(ref
                                        .watch(groupListProvider)
                                        .groups[index]
                                        .startDate) +
                                    "-" +
                                    convertDate(ref
                                        .watch(groupListProvider)
                                        .groups[index]
                                        .endDate),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0XFF4f4f4f),
                                        fontWeight: FontWeight.w400),
                                    children: [
                                      const TextSpan(text: "You owe "),
                                      TextSpan(
                                          text:
                                              "Rp${ref.watch(groupListProvider).groups[index].totalUnpaid}",
                                          style: const TextStyle(
                                            color: Color(0XFFF10D0D),
                                            fontWeight: FontWeight.w800,
                                          )),
                                      const TextSpan(text: " in total"),
                                    ]),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Rp${ref.watch(groupListProvider).groups[index].totalExpense}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                              getBubbleMember(ref.watch(groupListProvider).groups[index].members),
                            ]),
                      ]),
                ));
          },
        ))
      ]));
}
