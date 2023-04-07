import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../model/profile_color.dart';

convertDate(inputDate) {
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
  final outputFormat = DateFormat("dd MMM yyyy");

  final date = inputFormat.parse(inputDate);
  final result = outputFormat.format(date);

  return result; // Output: 01-Mar-2023
}

String formatNumber(int number) {
  String str = number.toString();
  String formatted = '';
  int len = str.length;

  for (int i = 0; i < len; i++) {
    formatted += str[i];

    // Add a dot after every three digits
    if ((len - i - 1) % 3 == 0 && i != len - 1) {
      formatted += '.';
    }
  }

  return formatted;
}


List<ProfileColor> profileColors = [
  // red
  ProfileColor(
    const Color.fromARGB(255, 227, 117, 117),
    const Color.fromARGB(255, 255, 212, 212), 
  ),
  // orange
  ProfileColor(
    const Color.fromARGB(255, 234, 151, 79),
    const Color.fromARGB(255, 249, 223, 200),
  ),
  // yellow
  ProfileColor(
    const Color.fromARGB(255, 241, 185, 40),
    const Color.fromARGB(255, 255, 238, 193), 
  ),
  // blue
  ProfileColor(
    const Color.fromARGB(255, 99, 161, 119),
    const Color.fromARGB(255, 233, 247, 223), 
  ),
  // teal
  ProfileColor(
    const Color.fromARGB(255, 73, 205, 196),
    const Color.fromARGB(255, 211, 255, 252), 
  ),
  // green
  ProfileColor(
    const Color.fromARGB(255, 34, 138, 155),
    const Color.fromARGB(255, 193, 233, 255), 
  ),
  // deep blue
  ProfileColor(
    const Color.fromARGB(255, 103, 126, 182),
    const Color.fromARGB(255, 218, 229, 255), 
  ),
  // purple
  ProfileColor(
    const Color.fromARGB(255, 172, 114, 208),
    const Color.fromARGB(255, 243, 224, 255), 
  ),
  // pink
  ProfileColor(
    const Color.fromARGB(255, 216, 66, 182),
    const Color.fromARGB(255, 255, 224, 248), 
  ),
];

  
  

  
 
 

getProfileTextColor(code) {
  return profileColors[code].textColor; 
}

getProfileBgColor(code) {
  return profileColors[code].bgColor;
}

getProfileColorCode(Color color) {
  for (var i = 0; i < profileColors.length; i++) {
    if (profileColors[i].bgColor == color) {
      return i;
    }
  }
}
