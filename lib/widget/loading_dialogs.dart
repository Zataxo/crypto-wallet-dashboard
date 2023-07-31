import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingDialogs extends StatefulWidget {
  const LoadingDialogs({Key? key}) : super(key: key);

  @override
  State<LoadingDialogs> createState() => _LoadingDialogsState();
}

class _LoadingDialogsState extends State<LoadingDialogs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.threeRotatingDots(
          color: const Color(0xff64CFF9),
          size: 60,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Transfering ... ",
            style: TextStyle(color: Color(0xffFFFFFF)),
          ),
        )
      ],
    );
  }
}
