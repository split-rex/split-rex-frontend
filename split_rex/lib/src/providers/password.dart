import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String email = "";
  String code = "";
  String encryptedToken = "";
  bool timerStopped = false;

  changeCode(String newCode) {
    code = newCode;

    notifyListeners();
  }

  changeEmail(String newEmail) {
    email = newEmail;

    notifyListeners();
  }

  changeToken(String newEncryptedToken) async {
    encryptedToken = newEncryptedToken;

    notifyListeners();
  }

  changeTimerStopped(bool stopped) {
    timerStopped = stopped;

    notifyListeners();
  }
}

final forgotPasswordProvider =
    ChangeNotifierProvider((ref) => ForgotPasswordProvider());
