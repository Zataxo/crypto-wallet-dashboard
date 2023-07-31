import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.buttonName,
    this.icon,
    this.onPressed,
    this.isLoading,
    this.buttonColor,
  }) : super(key: key);

  final Widget? icon;
  final String buttonName;
  final Function()? onPressed;
  final bool? isLoading;
  final Color? buttonColor;
  // late bool? isPressed = false;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color:
                widget.buttonColor ?? const Color(0xff01E4BF).withOpacity(0.9),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          onPressed: widget.onPressed,
          child: widget.icon == null
              ? Center(
                  child: widget.isLoading == true
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          widget.buttonName,
                          style: const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.bold),
                        ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.buttonName,
                      style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.bold),
                    ),
                    widget.icon!
                  ],
                ),
        ),
      ),
    );
  }
}
