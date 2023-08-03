import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReloadButton extends StatefulWidget {
  final Function() onTap;
  final Color? color;
  const ReloadButton({Key? key, this.color, required this.onTap})
      : super(key: key);

  @override
  State<ReloadButton> createState() => _ReloadButtonState();
}

class _ReloadButtonState extends State<ReloadButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: InkWell(
          onTap: () {
            _controller.forward().then((value) => _controller.reset());
            widget.onTap();
          },
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: SvgPicture.asset(
                'assets/icons/refresh_icon.svg',
                color: widget.color ?? const Color(0xff4E9C98).withOpacity(0.5),
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      );
    });
  }
}
