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

String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String formattedDate = DateFormat('dd MMM yyyy').format(date);
  return formattedDate;
}

String formatDateJson(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  return formattedDate;
}

String formatNumber(double number) {
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

double nearestTenMultiple(double number) {
  double result = 10;

  while (result < number) {
    result *= 10;
  }

  return result;
}

String abbreviateNumber(double number) {
  const Map<int, String> suffixes = {
    3: 'K',
    6: 'mil', // 10^6
    9: 'bil', // 10^9
    12: 'tril', // 10^12
    15: 'quadril', // 10^15
    18: 'quintil', // 10^18
    21: 'sextil', // 10^21
    24: 'septil', // 10^24
    27: 'oktil', // 10^27
    30: 'nonil', // 10^30
    33: 'desil', // 10^33
  };

  int suffixIndex = 0;
  while (number >= 1000 && suffixIndex < suffixes.length - 1) {
    number /= 1000;
    suffixIndex++;
  }

  final suffix = suffixes[suffixIndex * 3];
  return '${number.toInt().toString()} $suffix';
}

String formatDouble(double number) {
  String str = number.toInt().toString();
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

double findLargest(List<double> arr) {
  double largest = arr[0]; // assume the first element is the largest

  for (int i = 1; i < arr.length; i++) {
    if (arr[i] > largest) {
      largest = arr[i];
    }
  }

  return largest;
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

String extractMonth(String input) {
  Map<int, String> monthMap = {
    1: 'JAN',
    2: 'FEB',
    3: 'MAR',
    4: 'APR',
    5: 'MAY',
    6: 'JUN',
    7: 'JUL',
    8: 'AUG',
    9: 'SEP',
    10: 'OCT',
    11: 'NOV',
    12: 'DEC'
  };
  int month = int.parse(input.substring(5, 7));
  return monthMap[month]!;
}

String extractDate(String input) {
  DateTime dateTime = DateTime.parse(input);
  int day = dateTime.day;
  String dayStr = day.toString().padLeft(2, '0');
  return dayStr;
}

String getFullMonthName(String monthAbbr) {
  final Map<String, String> monthMap = {
    'JAN': 'January',
    'FEB': 'February',
    'MAR': 'March',
    'APR': 'April',
    'MAY': 'May',
    'JUN': 'June',
    'JUL': 'July',
    'AUG': 'August',
    'SEP': 'September',
    'OCT': 'October',
    'NOV': 'November',
    'DEC': 'December',
  };

  return monthMap[monthAbbr.toUpperCase()] ?? '';
}
