import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingDashboard extends StatefulWidget {
  const LoadingDashboard({Key? key}) : super(key: key);

  @override
  State<LoadingDashboard> createState() => _LoadingDashboardState();
}

class _LoadingDashboardState extends State<LoadingDashboard> {
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(
      color: const Color(0xff64CFF9),
      size: 50,
    );
  }
}
