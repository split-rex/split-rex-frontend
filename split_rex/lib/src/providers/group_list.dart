import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/model/group_model.dart';

import '../common/logger.dart';
import '../model/add_expense.dart';
import '../model/friends.dart';

class GroupListProvider extends ChangeNotifier {
  bool hasOwedGroups = false;
  bool hasLentGroups = false;
  List<GroupListModel> groups = <GroupListModel>[];
  List<GroupListModel> groupsLoaded = <GroupListModel>[];
  GroupListModel currGroup = GroupListModel("", "", [], "", "", "", 0, 0);
  bool isOwed = true;


  void updateHasOwedGroups(bool val) {
    hasOwedGroups = val;
    notifyListeners();
  }

  void updateHasLentGroups(bool val) {
    hasLentGroups = val;
    notifyListeners();
  }

  void clearGroupListProvider() {
    groups = <GroupListModel>[];
    groupsLoaded = <GroupListModel>[];
    currGroup = GroupListModel("", "", [], "", "", "", 0, 0);
    isOwed = true;
    notifyListeners();
  }

  void changeIsOwed(bool value) {
    isOwed = value;
    notifyListeners();
  }

  void changeCurrGroup(GroupListModel group) {
    currGroup = group;
  }

  void changeCurrGroupTransactions(List<Transaction> transactions) {
    currGroup.transactions = transactions;
  }

  void changeCurrGroupActivity(List<GroupActivity> groupActivities) {
    currGroup.groupActivities = groupActivities;
  }

  void changeCurrGroupById(String groupId) {
    for (int i = 0; i < groupsLoaded.length; i++) {
      if (groups[i].groupId == groupId) {
        currGroup = groups[i];
        break;
      }
    }
  }

  void changeCurrGroupDetail(dynamic groupDetail) {
    currGroup.groupId = groupDetail["group_id"];
    currGroup.name = groupDetail["name"];
    currGroup.startDate = groupDetail["start_date"].toString();
    currGroup.endDate = groupDetail["end_date"].toString();
    currGroup.type = groupDetail["type"];
    currGroup.totalUnpaid = groupDetail["total_unpaid"];
    currGroup.totalExpense = groupDetail["total_expense"];
    var dataMemberList = groupDetail["list_memberr"];

    List<Friend> memberList = <Friend>[];
    for (int i = 0; i < dataMemberList.length; i++) {
      var currMember = dataMemberList[i];

      var friendObj = Friend(
          userId: currMember["member_id"],
          name: currMember["name"],
          username: currMember["username"],
          color: currMember["color"],
          email: currMember["email"]);
      friendObj.paymentInfo = {};
      friendObj.flattenPaymentInfo = [];
      var paymentInfo = currMember["payment_info"];

      if (paymentInfo != null) {
        for (var paymentMethod in paymentInfo.keys) {
          Map<int, String> listOfAcc = <int, String>{};
          for (var accountNumber in paymentInfo[paymentMethod].keys) {
            var accountName = paymentInfo[paymentMethod][accountNumber];
            listOfAcc[int.parse(accountNumber)] = accountName;

            friendObj.flattenPaymentInfo.add([
              paymentMethod,
              accountNumber,
              accountName,
            ]);
          }
          friendObj.paymentInfo[paymentMethod] = listOfAcc;
        }
      }

      memberList.add(friendObj);
    }
    currGroup.members = memberList;
  }

  void loadGroupData(dynamic modelList) {
    groups.clear();
    groupsLoaded.clear();
    if (modelList != null) {
      for (int i = 0; i < modelList.length; i++) {
        var group = GroupListModel(
            modelList[i]["group_id"],
            modelList[i]["name"],
            modelList[i]["member_id"],
            modelList[i]["start_date"],
            modelList[i]["end_date"],
            modelList[i]["type"],
            (modelList[i]["total_unpaid"]).toInt(),
            modelList[i]["total_expense"]);

        var dataMemberList = modelList[i]["list_memberr"];
        List<Friend> memberList = <Friend>[];
        for (int i = 0; i < dataMemberList.length; i++) {
          var currMember = dataMemberList[i];
          var friendObj = Friend(
              userId: currMember["member_id"],
              name: currMember["name"],
              username: currMember["username"],
              color: currMember["color"],
              email: currMember["email"]);
          friendObj.paymentInfo = {};
          friendObj.flattenPaymentInfo = [];
          var paymentInfo = currMember["payment_info"];

          if (paymentInfo != null) {
            for (var paymentMethod in paymentInfo.keys) {
              Map<int, String> listOfAcc = <int, String>{};
              for (var accountNumber in paymentInfo[paymentMethod].keys) {
                var accountName = paymentInfo[paymentMethod][accountNumber];
                listOfAcc[int.parse(accountNumber)] = accountName;

                friendObj.flattenPaymentInfo.add([
                  paymentMethod,
                  accountNumber,
                  accountName,
                ]);
              }
              friendObj.paymentInfo[paymentMethod] = listOfAcc;
            }
          }

          memberList.add(friendObj);
        }

        group.members = memberList;
        groups.add(group);
        groupsLoaded.add(group);
      }
    }

    notifyListeners();
  }

  void searchGroupName(String name) {
    // int len = groupsLoaded.length;
    // List<GroupListModel> builder = [];
    // List<GroupListModel> groupsLoad = groupsLoaded;

    // // print(groupsLoad);
    // for (int i = 0; i < len; i++) {
    //   if (groupsLoaded[i].name.toLowerCase().contains(name.toLowerCase())) {
    //     print("here");
    //     builder.add(groupsLoaded[i]);
    //   }
    // }
    // // print(groupsLoad[1].name);
    // groups = builder;
    // groups = groups;
    // print(groups);
    // notifyListeners();
    int len = groupsLoaded.length;
    groups.clear();

    // print(groupsLoad);
    for (int i = 0; i < len; i++) {
      if (groupsLoaded[i].name.toLowerCase().contains(name.toLowerCase())) {
        logger.d("here");
        groups.add(groupsLoaded[i]);
      }
    }
    logger.d(groups.length);
    logger.d(groupsLoaded);
    notifyListeners();
  }

  void searchGroupNameOne(String name) {
    // int len = groupsLoaded.length;
    // List<GroupListModel> builder = [];
    // List<GroupListModel> groupsLoad = groupsLoaded;

    // // print(groupsLoad);
    // for (int i = 0; i < len; i++) {
    //   if (groupsLoaded[i].name.toLowerCase().contains(name.toLowerCase())) {
    //     print("here");
    //     builder.add(groupsLoaded[i]);
    //   }
    // }
    // // print(groupsLoad[1].name);
    // groups = builder;
    // groups = groups;
    // print(groups);
    // notifyListeners();
    int len = groupsLoaded.length;

    // print(groupsLoad);
    for (int i = 0; i < len; i++) {
      if (groupsLoaded[i].name.toLowerCase().contains(name.toLowerCase())) {
        currGroup = groupsLoaded[i];
      }
    }
 
    notifyListeners();
  }
}



final groupListProvider = ChangeNotifierProvider((ref) => GroupListProvider());

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
