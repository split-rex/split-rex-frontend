import 'package:intl/intl.dart';

convertDate(inputDate) {
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ");
  final outputFormat = DateFormat("dd MMM yyyy");

  final date = inputFormat.parse(inputDate);
  final result = outputFormat.format(date);

  return result; // Output: 01-Mar-2023
}
