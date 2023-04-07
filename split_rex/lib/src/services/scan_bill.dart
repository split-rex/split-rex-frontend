import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// TODO (tp boong): JANGAN DIAPUSSSS !!!
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:split_rex/src/common/logger.dart';
import 'package:split_rex/src/model/add_expense.dart';
import 'package:split_rex/src/providers/add_expense.dart';

int strToInt(String input) {
  bool endsWithDot = RegExp(r'\.00$').hasMatch(input);
  bool endsWithComma = RegExp(r'\,00$').hasMatch(input);

  if (endsWithDot) {
    input = input.replaceAll(RegExp(r'\.00$'), '');
  }

  if (endsWithComma) {
    input = input.replaceAll(RegExp(r'\,00$'), '');
  }

  var res = input.replaceAll(RegExp(r'[^0-9]'), '');
  return int.parse(res);
}

class ScanBillServices {
  String endpoint = "https://split-rex-ocr-v2-7v6i6rndga-et.a.run.app/ocr";

  Future<void> postBill(WidgetRef ref, File file) async {
    var stream = ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();
    MultipartRequest request = MultipartRequest('POST', Uri.parse(endpoint));
    request.files.add(MultipartFile('file', stream, length, filename: basename(file.path), contentType: MediaType('image', 'jpg')));
    StreamedResponse response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      ref.watch(addExpenseProvider).resetAll();
      logger.d(value);
      var resp = jsonDecode(value)["data"][0];
      logger.d(resp);
      if (resp.containsKey("tax")) {
        ref.read(addExpenseProvider).changeBillTax(strToInt(resp["tax"]).toString());
      }
      if (resp.containsKey("service")) {
        ref.read(addExpenseProvider).changeBillService(strToInt(resp["service"]).toString());
      }
      if (resp.containsKey("items")) {
        ref.read(addExpenseProvider).resetItems();
        var items = resp["items"];
        for (var i = 0; i < items.length; i++) {
          var currentItem = items[i];
          Items tempItem = Items();
          tempItem.name = currentItem["name"];
          tempItem.qty = strToInt(currentItem["qty"]);
          tempItem.total = strToInt(currentItem["total_price"]);
          tempItem.price = tempItem.total ~/ tempItem.qty;
          ref.read(addExpenseProvider).addItem(tempItem);
          ref.read(addExpenseProvider).addBillSubtotalTotal(tempItem.total);
        }
      }
    });
  }
}
