import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/services/auth.dart';

import 'package:split_rex/src/widgets/group_list.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupList extends ConsumerWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiServices().readJson(ref);
    return header(
      context, 
      ref,
      "Groups",
      "home",
      Container(

        padding: const EdgeInsets.only(top: 8.0),
            child: 
              Column(
                children: [
                  searchBar(),
                  Expanded(
                    flex: 5, 
                    child: showGroups(context, ref)
                  ),
                  
                ],
              ),

      ), 
    );
  }
}
