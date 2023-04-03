import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:split_rex/src/providers/group_list.dart';
import '../../providers/friend.dart';
import '../../providers/routes.dart';
import '../friends/friends.dart';

var logger = Logger();

class GroupNameSection extends ConsumerWidget {
  const GroupNameSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 40.0,
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              ref.watch(groupListProvider).currGroup.name,
              style: const TextStyle(
                  fontSize: 27,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            InkWell(
              onTap: () => {
                logger.d("tapped"),
                ref.watch(routeProvider).changePage("group_settings_edit"),
              },
              child: const Icon(
                Icons.edit,
                color: Colors.grey,
              ),
            )
          ],
        ));
  }
}

class GroupNameSectionEdit extends ConsumerStatefulWidget {
  const GroupNameSectionEdit({super.key});

  @override
  ConsumerState<GroupNameSectionEdit> createState() => _GroupNameSectionEdit();
}

class _GroupNameSectionEdit extends ConsumerState<GroupNameSectionEdit> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 40.0,
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            TextField(
                key: UniqueKey(),
                controller: nameController,
                cursorColor: const Color(0xFF59C4B0),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    filled: true,
                    hintText: ref.watch(groupListProvider).currGroup.name,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: const Icon(Icons.edit, color: Colors.grey)))
          ],
        ));
  }
}

class AddGroupMembersSection extends ConsumerWidget {
  const AddGroupMembersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(friendProvider).resetAddFriend();
        ref.watch(friendProvider).getFriendNotInGroup(
                      ref.watch(groupListProvider).currGroup.members);
        ref.watch(routeProvider).changePage("choose_friend_group_settings");
      },
      child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 40.0,
          padding: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0), // Shadow position
              ),
            ],
          ),
          child: Row(
            children: const [
              Icon(Icons.group_add),
              SizedBox(width: 10),
              Text(
                "Add New Members",
                style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          )),
    );
  }
}

class GroupMembers extends ConsumerWidget {
  
  const GroupMembers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return Container(
      width: MediaQuery.of(context).size.width - 40.0,
      padding: const EdgeInsets.only(top: 25, bottom: 10, left: 20, right: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ref.watch(groupListProvider).currGroup.members.isEmpty
              ? const Text("You don't have any friend at the moment")
              : Text(
                  "Group Members (${ref.watch(groupListProvider).currGroup.members.length})",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.separated(
                itemCount:
                    ref.watch(groupListProvider).currGroup.members.length,
                padding: const EdgeInsets.only(top: 12),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FriendList(
                    name: ref
                        .watch(groupListProvider)
                        .currGroup
                        .members[index]
                        .name,
                    color: ref
                        .watch(groupListProvider)
                        .currGroup
                        .members[index]
                        .color,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  indent: 20,
                  color: Color(0xFFE1F3F2),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
