import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:split_rex/src/common/logger.dart';

class ScanBillServices {
  String endpoint = "http://9723-34-83-153-36.ngrok.io/ocr";


  Future<void> postBill(WidgetRef ref, File file) async {
    var stream = ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();
    MultipartRequest request = MultipartRequest("POST", Uri.parse(endpoint));
    request.files.add(MultipartFile('image', stream, length, filename: basename(file.path), contentType: MediaType('image', 'jpg')));
    StreamedResponse response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      logger.d(value);
    });
  }
}
