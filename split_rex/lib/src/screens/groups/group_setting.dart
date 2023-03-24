import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/group_model.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/group.dart';
import 'package:split_rex/src/widgets/groups/group_settings.dart';

import '../../common/header.dart';
import '../../providers/group_list.dart';

class GroupSettings extends ConsumerWidget {
  const GroupSettings({super.key, required this.group});

  final GroupListModel group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
        context,
        ref,
        "Group Settings",
        "group_detail",
        Column(
          children: const [
            GroupNameSection(),
            // TODO: bisa add new member ke group
            // SizedBox(height: 15),
            // AddGroupMembersSection(),
            SizedBox(height: 15),
            GroupMembers(),
          ],
        ));
  }
}

class GroupSettingsEdit extends ConsumerStatefulWidget {
  const GroupSettingsEdit({super.key});

  @override
  ConsumerState<GroupSettingsEdit> createState() => _GroupNameSectionEdit();
}

class _GroupNameSectionEdit extends ConsumerState<GroupSettingsEdit> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return header(
        context,
        ref,
        "Edit Group",
        "group_settings",
        Column(
          children: [
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 20.0,
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.centerLeft,
                child: TextField(
                    key: UniqueKey(),
                    controller: nameController,
                    cursorColor: const Color(0xFF59C4B0),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        filled: true,
                        hintText: ref.watch(groupListProvider).currGroup.name,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon:
                            const Icon(Icons.edit, color: Colors.grey)))),
            SubmitGroupSettingBtn(
              nameController: nameController,
            )
          ],
        ));
  }
}

class SubmitGroupSettingBtn extends ConsumerWidget {
  final TextEditingController? nameController;

  const SubmitGroupSettingBtn({super.key, this.nameController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 40, right: 40, top: 30),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF59C4B0),
            Color(0XFF43A7B7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: InkWell(
        onTap: () async => {
          await GroupServices().editGroupInfo(
              ref,
              ref.watch(groupListProvider).currGroup.groupId,
              nameController!.text),
          ref.read(routeProvider).changePage("group_settings"),

          // TODO: Add toaster success edit
        },
        child: const Text(
          "Save group settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
