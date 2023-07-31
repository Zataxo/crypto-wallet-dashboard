import 'package:crypto_statistics/utils/enums.dart';
import 'package:flutter/cupertino.dart';

class DashboardViewModel with ChangeNotifier {
  LoadingState state = LoadingState.intial;
  void setLoadingState(LoadingState value) {
    state = value;
    notifyListeners();
  }
}
