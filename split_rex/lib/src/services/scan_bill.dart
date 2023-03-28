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

// TODO masi janky
class ScanBillServices {
  String endpoint = "http://847a-35-204-185-137.ngrok.io/ocr";

  Future<void> postBill(WidgetRef ref, File file) async {
    var stream = ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();
    MultipartRequest request = MultipartRequest("POST", Uri.parse(endpoint));
    request.files.add(MultipartFile('image', stream, length, filename: basename(file.path), contentType: MediaType('image', 'jpg')));
    StreamedResponse response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      ref.watch(addExpenseProvider).resetAll();
      logger.d(value);
      var resp = jsonDecode(value)[0];
      logger.d(resp);
      if (value.contains("nm") || value.contains("menu")) {
        // ignore: prefer_typing_uninitialized_variables
        var itemObj;
        if (value.contains("menu") && !(value.contains("menuqty_cnt"))) {
          if (resp is List) {
            itemObj = resp[0]["menu"];
          } else {
            itemObj = resp["menu"];
          }
        } else if (value.contains("nm")) {
          if (resp is List) {
            itemObj = resp[0];
          } else {
            itemObj = resp;
          }
        }
        logger.d(itemObj);
        for (var i = 0; i < itemObj.length; i++) {
          var currentItem = itemObj[i];
          Items tempItem = Items();
          logger.d(currentItem);
          if (currentItem.containsKey("nm")) {
            tempItem.name = currentItem["nm"].toString();
          }
          if (currentItem.containsKey("cnt")) {
            tempItem.qty = int.parse(currentItem["cnt"].replaceAll(',', '').replaceAll(' ', ''));
          }
          if (currentItem.containsKey("unitprice")) {
            tempItem.price = int.parse(currentItem["unitprice"].replaceAll(',', '').replaceAll(' ', ''));
          } else {
            if (currentItem.containsKey("price")) {
              tempItem.price = int.parse(currentItem["price"].replaceAll(',', '').replaceAll(' ', '')) ~/ tempItem.qty;
            }
          }
          tempItem.total = tempItem.qty * tempItem.price;
          ref.read(addExpenseProvider).addItem(tempItem);
          ref.read(addExpenseProvider).addBillSubtotalTotal(tempItem.total);
        }
      }
    });
  }
}
