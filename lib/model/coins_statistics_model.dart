import 'package:flutter/cupertino.dart';

class CoinsStatistics {
  String coinLogo;
  String coinName;
  String coinShortcut;
  Color lineColor;
  int priceInUSD;
  double coinValue;
  bool increment;
  double incrementValue;
  CoinsStatistics(
      {required this.coinLogo,
      required this.coinName,
      required this.coinShortcut,
      required this.lineColor,
      required this.priceInUSD,
      required this.coinValue,
      required this.increment,
      required this.incrementValue});
}
