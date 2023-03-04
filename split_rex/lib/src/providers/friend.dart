import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/friends.dart';

class FriendProvider extends ChangeNotifier {
  List<Friend> friendList = <Friend>[];
  List<Friend> friendReceivedList = <Friend>[];
  List<Friend> friendSentList = <Friend>[];
  Friend addFriend = Friend(name: "");
  bool isReceived = true;

  changeUserFriendList(val) {
    friendList.clear();

    for (var friend in val) {
      var friendObj = Friend(
        userId: friend["user_id"],
        username: friend["username"],
        name: friend["fullname"],
      );

      friendList.add(friendObj);
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
      );

      friendSentList.add(friendObj);
    }

    notifyListeners();
  }

  changeAddFriend(val) {
    addFriend = Friend(
        username: val["username"],
        userId: val["user_id"],
        name: val["fullname"]);

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
}

final friendProvider = ChangeNotifierProvider((ref) => FriendProvider());
