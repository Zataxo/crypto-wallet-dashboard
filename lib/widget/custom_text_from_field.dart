import 'package:crypto_statistics/utils/util_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      this.isPassword,
      this.validator,
      this.hintText,
      this.hintTextStyle,
      this.icon,
      this.fillColor,
      this.inputColor,
      this.customPadding})
      : super(key: key);
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final Icon? icon;
  final Color? fillColor;
  final Color? inputColor;
  final EdgeInsets? customPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPadding ?? const EdgeInsets.all(0.0),
      child: Container(
        // width: size.width * 0.2,
        // height: size.height * 0.05,
        decoration: BoxDecoration(
            color: fillColor ?? const Color(0xffEAF0F7),
            borderRadius: BorderRadius.circular(5)),
        child: Consumer<UtilLogic>(
            builder: (context, utilLogicProvider, child) => TextFormField(
                  controller: controller,
                  validator: validator,
                  obscureText: isPassword == true
                      ? utilLogicProvider.isPasswordObsecure
                      : false,
                  style: TextStyle(
                      color: inputColor ?? const Color(0xff000000),
                      fontSize: 14),
                  decoration: InputDecoration(
                      fillColor: const Color(0xffFFFFFF),
                      hintText: hintText,
                      hintStyle: hintTextStyle,
                      suffixIcon: isPassword != null && isPassword == true
                          ? IconButton(
                              onPressed: () {
                                utilLogicProvider.changePasswordVisibilty();
                              },
                              icon: utilLogicProvider.isPasswordObsecure
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Color(0xff14162E),
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Color(0xff14162E),
                                    ))
                          : icon,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12.0)),
                )),
      ),
    );
  }
}
