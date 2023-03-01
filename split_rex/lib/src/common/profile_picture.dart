import 'package:flutter/material.dart';

String getInitials(String fullname) => 
  fullname.isNotEmpty ? 
  fullname.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
  : '';

Widget profilePicture(String fullname) => 
  CircleAvatar(
    backgroundColor: const Color(0XFFEEEEEE),
    child: Text(
      getInitials(fullname), 
      style: const TextStyle(
        color: Color(0XFF979797),
        fontWeight: FontWeight.w500
      )
    ),
  ); 