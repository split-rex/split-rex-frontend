import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/friends.dart';

class FriendProvider extends ChangeNotifier {
  List<Friend> friendList = <Friend>[];
  List<Friend> friendReceivedList = <Friend>[];
  List<Friend> friendSentList = <Friend>[];
  List<Friend> friendSearched = <Friend>[];
  List<Friend> friendNotInGroup = <Friend>[];
  List<Friend> friendNotInGroupLoaded = <Friend>[];
  List<Friend> friendInGroup = <Friend>[];
  Friend addFriend = Friend(name: "");
  bool isReceived = true;

  clearFriendProvider() {
    friendList = <Friend>[];
    friendReceivedList = <Friend>[];
    friendSentList = <Friend>[];
    friendSearched = <Friend>[];
    friendNotInGroup = <Friend>[];
    friendNotInGroupLoaded = <Friend>[];
    friendInGroup = <Friend>[];
    addFriend = Friend(name: "");
    isReceived = true;
    notifyListeners();
  }

  changeUserFriendList(val) {
    friendList.clear();
    friendSearched.clear();

    for (var friend in val) {
      var friendObj = Friend(
        userId: friend["user_id"],
        username: friend["username"],
        name: friend["fullname"],
        color: friend["color"],
      );

      friendObj.paymentInfo = {};
      friendObj.flattenPaymentInfo = [];
      var paymentInfo = friend["payment_info"];

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

      friendList.add(friendObj);
      friendSearched.add(friendObj);
    }

    notifyListeners();
  }

  changeUserReceivedList(val) {
    friendReceivedList.clear();

    for (var friend in val) {
      var friendObj = Friend(
        userId: friend["user_id"],
        username: friend["username"],
        name: friend["fullname"],
        color: friend["color"],
      );

      friendReceivedList.add(friendObj);
    }
    notifyListeners();
  }

  changeUserSentList(val) {
    friendSentList.clear();

    for (var friend in val) {
      var friendObj = Friend(
        userId: friend["user_id"],
        username: friend["username"],
        name: friend["fullname"],
        color: friend["color"],
      );

      friendSentList.add(friendObj);
    }

    notifyListeners();
  }

  changeAddFriend(val) {
    addFriend = Friend(
        username: val["username"],
        userId: val["user_id"],
        name: val["fullname"],
        color: val["color"]);

    notifyListeners();
  }

  resetAddFriend() {
    addFriend = Friend(name: "");

    notifyListeners();
  }

  changeIsReceived(bool val) {
    isReceived = val;

    notifyListeners();
  }

  searchFriendName(String name) {
    int len = friendList.length;
    friendSearched.clear();

    for (int i = 0; i < len; i++) {
      if (friendList[i].name.toLowerCase().contains(name.toLowerCase())) {
        friendSearched.add(friendList[i]);
      }
    }

    notifyListeners();
  }

  searchFriendNameFromList(String name, List<Friend> friendtosearch) {
    int len = friendtosearch.length;
    friendSearched.clear();

    for (int i = 0; i < len; i++) {
      if (friendtosearch[i].name.toLowerCase().contains(name.toLowerCase())) {
        friendSearched.add(friendList[i]);
      }
    }

    notifyListeners();
  }

  getFriendNotInGroup(List<dynamic> groupMembers) {
    friendNotInGroup.clear();
    friendNotInGroupLoaded.clear();
    List<String> memberId = <String>[];

    for (var member in groupMembers) {
      memberId.add(member.userId);
    }

    for (var friend in friendList) {
      if (!memberId.contains(friend.userId)) {
        friendNotInGroup.add(friend);
        friendNotInGroupLoaded.add(friend);
      }
    }

    notifyListeners();
  }

  searchFriendNotInGroup(String name) {
    // log(name);
    int len = friendNotInGroupLoaded.length;
    friendNotInGroup.clear();

    for (int i = 0; i < len; i++) {
      log(friendNotInGroupLoaded[i].name.toLowerCase());
      if (friendNotInGroupLoaded[i]
          .name
          .toLowerCase()
          .contains(name.toLowerCase())) {
        friendNotInGroup.add(friendNotInGroupLoaded[i]);
      }
    }

    notifyListeners();
  }

  // getFriendInGroup(List<Friend> groupMembers) {
  //   friendInGroup.clear();

  //   for (var friend in friendList) {
  //     if (!groupMembers.contains(friend)) {
  //       friendNotInGroup.add(friend);
  //     }
  //   }

  //   notifyListeners();
  // }

  Friend getFriend(memberId) {
    return friendList.firstWhere((friend) => friend.userId == memberId);
  }
}

final friendProvider = ChangeNotifierProvider((ref) => FriendProvider());
