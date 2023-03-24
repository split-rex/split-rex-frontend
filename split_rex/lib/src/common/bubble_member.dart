import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

import 'functions.dart';

getBubbleMember(memberList) {
  var length = memberList.length;
  if (length <= 0) {
    return const SizedBox();
  } else if (length == 1) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: 35,
      child: Stack(
        children: <Widget>[
          Positioned(
              child: CircleAvatar(
            backgroundColor: getProfileTextColor(memberList[0].color),
            radius: 17,
            child: Initicon(
              text: memberList[0].name,
              size: 30,
              backgroundColor: getProfileBgColor(memberList[0].color),
              style: TextStyle(color: getProfileTextColor(memberList[0].color)),
            ),
          )),
        ],
      ),
    );
  } else if (length == 2) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: 55,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 20,
              child: CircleAvatar(
                backgroundColor: getProfileTextColor(memberList[0].color),
                radius: 17,
                child: Initicon(
                  text: memberList[0].name,
                  size: 30,
                  backgroundColor: getProfileBgColor(memberList[0].color),
                  style: TextStyle(
                      color: getProfileTextColor(memberList[0].color)),
                ),
              )),
          Positioned(
              child: CircleAvatar(
            backgroundColor: getProfileTextColor(memberList[1].color),
            radius: 17,
            child: Initicon(
              text: memberList[1].name,
              size: 30,
              backgroundColor: getProfileBgColor(memberList[1].color),
              style: TextStyle(color: getProfileTextColor(memberList[1].color)),
            ),
          )),
        ],
      ),
    );
  } else if (length >= 3) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: 75,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 40,
              child: CircleAvatar(
                backgroundColor: getProfileTextColor(memberList[0].color),
                radius: 17,
                child: Initicon(
                  text: memberList[0].name,
                  size: 30,
                  backgroundColor: getProfileBgColor(memberList[0].color),
                  style: TextStyle(
                      color: getProfileTextColor(memberList[0].color)),
                ),
              )),
          Positioned(
              left: 20,
              child: CircleAvatar(
                backgroundColor: getProfileTextColor(memberList[1].color),
                radius: 17,
                child: Initicon(
                  text: memberList[1].name,
                  size: 30,
                  backgroundColor: getProfileBgColor(memberList[1].color),
                  style: TextStyle(
                      color: getProfileTextColor(memberList[1].color)),
                ),
              )),
          Positioned(
              child: CircleAvatar(
            backgroundColor: getProfileTextColor(memberList[2].color),
            radius: 17,
            child: Initicon(
              text: memberList[2].name,
              size: 30,
              backgroundColor: getProfileBgColor(memberList[2].color),
              style: TextStyle(color: getProfileTextColor(memberList[2].color)),
            ),
          )),
        ],
      ),
    );
  }
}
