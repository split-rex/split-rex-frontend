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

List<ProfileColor> profileColors = [
  // red
  ProfileColor(
    const Color.fromARGB(255, 255, 79, 79),
    const Color.fromARGB(255, 255, 215, 215), 
  ),
  // orange
  ProfileColor(
    const Color.fromARGB(255, 255, 174, 74),
    const Color.fromARGB(255, 255, 234, 209),
  ),
  // yellow
  ProfileColor(
    const Color.fromARGB(255, 255, 207, 75),
    const Color(0xFFFFEEC1), 
  ),
  // blue
  ProfileColor(
    const Color.fromARGB(255, 73, 191, 255),
    const Color(0xFFC1E9FF), 
  ),
  // teal
  ProfileColor(
    const Color.fromARGB(255, 61, 255, 242),
    const Color(0xFFD3FFFC), 
  ),
  // green
  ProfileColor(
    const Color.fromARGB(255, 79, 255, 152),
    const Color.fromARGB(255, 211, 255, 229), 
  ),
  // deep blue
  ProfileColor(
    const Color.fromARGB(255, 83, 71, 255),
    const Color.fromARGB(255, 224, 222, 255), 
  ),
  // purple
  ProfileColor(
    const Color.fromARGB(255, 174, 74, 255),
    const Color.fromARGB(255, 241, 224, 255), 
  ),
  // pink
  ProfileColor(
    const Color.fromARGB(255, 255, 75, 198),
    const Color.fromARGB(255, 255, 224, 245), 
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
