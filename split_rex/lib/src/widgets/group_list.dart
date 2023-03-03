import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/screens/group_detail.dart';

import '../common/profile_picture.dart';

Widget searchBar() => Container(
     margin: const EdgeInsets.only(left: 18.0, right: 18.0),
    decoration: BoxDecoration(
      color: const Color(0XFFFFFFFF),
      border: Border.all(color: const Color.fromARGB(50, 154, 154, 176), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(14.0)),
    ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: const [
          Icon(
            Icons.search,
            color: Color(0XFF9A9AB0),
          ),
          SizedBox(width: 8.0),
          Text("Search for a group...",
              style: TextStyle(color: Color(0XFF9A9AB0)))
        ],
      ),
     
      
    );

Widget showGroups(BuildContext context, WidgetRef ref) {
  // ApiServices().readJson(ref);
  return Container(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(16.0),
          
          
          child: ListView.builder(
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
                  key: ValueKey(ref.watch(groupListProvider).groups[index].id),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => GroupDetail(group: ref.watch(groupListProvider).groups[index]),));
                    },
                    child:  Row(
                      
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
                                "${ref.watch(groupListProvider).groups[index].startDate} - ${ref.watch(groupListProvider).groups[index].endDate}",
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
                                          text: "Rp${ref.watch(groupListProvider).groups[index].totalUnpaid}",
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
                              Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.red,
                                        child: profilePicture("Pak Fitra"), // Provide your custom image
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.red,
                                        child: profilePicture("Michael Jordan"), // Provide your custom image
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.red,
                                        child: profilePicture("John Doe"), // Provide your custom image
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ]) ,)
                  
                 );
            },
          ),
        ))
      ]));
}
