import 'package:flutter/material.dart';
import 'package:split_rex/src/common/profile_picture.dart';

getBubbleMember() {
  return SizedBox(
    width: 80,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 40,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.red,
              child: profilePicture(
                  "Pak Fitra", 16.0), // Provide your custom image
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.red,
              child: profilePicture(
                  "Michael Jordan", 16.0), // Provide your custom image
            ),
          ),
        ),
        Positioned(
            child: InkWell(
          // onTap: () {
          //   ref.read(routeProvider).changePage("choose_friend");
          // },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.red,
              child:
                  profilePicture("John Doe", 16.0), // Provide your custom image
            ),
          ),
        )),
      ],
    ),
  );
}
