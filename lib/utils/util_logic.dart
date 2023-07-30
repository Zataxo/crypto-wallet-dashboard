import 'package:flutter/cupertino.dart';

class UtilLogic with ChangeNotifier {
  // bool isDarkMood = false;
  bool isPasswordObsecure = true;
  bool isButtonLoading = false;

  // void changeMood() {
  //   isDarkMood = !isDarkMood;
  //   notifyListeners();
  // }

  void changePasswordVisibilty() {
    isPasswordObsecure = !isPasswordObsecure;
    notifyListeners();
  }

  void setButtonLoading() {
    isButtonLoading = true;
    notifyListeners();
  }

  void stopButtonLoading() {
    isButtonLoading = false;
    notifyListeners();
  }
}
