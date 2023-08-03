import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorHandling extends StatelessWidget {
  const ErrorHandling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/icons/not_found.svg"),
      ],
    ));
  }
}
