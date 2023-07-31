import 'package:flutter/material.dart';

class PopMenuModel {
  IconData icon;
  String desc;
  Function() onPressed;
  PopMenuModel(
      {required this.icon, required this.desc, required this.onPressed});
}
