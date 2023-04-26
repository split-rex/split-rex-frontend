import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/logger.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String email = "";
  String token = "";
  String encryptedToken = "";
  bool timerStopped = false;
  final key = enc.Key.fromUtf8("112ksdf68jk2as768kj124ds0fsn1jhg");
  final iv = enc.IV.fromLength(16);

  changeEmail(String newEmail) {
    email = newEmail;

    notifyListeners();
  }

  changeToken(String token, String seal) async {
    token = token;

    AesGcm algorithm = AesGcm.with256bits();
    SecretKey secretKey =
        SecretKey(utf8.encode("112ksdf68jk2as768kj124ds0fsn1jhg"));
    List<int> nonce = algorithm.newNonce();
    logger.d(nonce);

    SecretBox secretBox = await algorithm.encrypt(
      utf8.encode(seal),
      secretKey: secretKey,
      nonce: nonce
    );

    logger.d(secretBox.toString());
    logger.d(base64.encode(secretBox.cipherText));
    // // encrypt token
    // enc.Encrypter encrypter = enc.Encrypter(enc.AES(key));
    // encryptedToken = encrypter.encrypt(token, iv: iv).base64;

    // logger.d(encryptedToken);
    // logger.d(encrypter.encrypt(seal, iv:iv).base64);

    // String testBox = await algorithm.decryptString(
    //   secretBox,
    //   secretKey: secretKey
    // )
  }

  changeTimerStopped(bool stopped) {
    timerStopped = stopped;

    notifyListeners();
  }
}

final forgotPasswordProvider =
    ChangeNotifierProvider((ref) => ForgotPasswordProvider());
