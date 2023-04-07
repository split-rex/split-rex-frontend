import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/logger.dart';

import '../model/friends.dart';

class FriendProvider extends ChangeNotifier {
  List<Friend> friendList = <Friend>[];
  List<Friend> friendReceivedList = <Friend>[];
  List<Friend> friendSentList = <Friend>[];
  List<Friend> friendSearched = <Friend>[];
  Friend addFriend = Friend(name: "");
  bool isReceived = true;

  clearFriendProvider() {
    friendList = <Friend>[];
    friendReceivedList = <Friend>[];
    friendSentList = <Friend>[];
    friendSearched = <Friend>[];
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

  Friend getFriend(memberId) {
    return friendList.firstWhere((friend) => friend.userId == memberId);
  }
}

final friendProvider = ChangeNotifierProvider((ref) => FriendProvider());
