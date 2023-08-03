import 'package:crypto_statistics/model/user_model.dart';
import 'package:crypto_statistics/view_model/login_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool isHover = false;
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        isHover = true;
        setState(() {});
      },
      onExit: (event) {
        isHover = false;
        setState(() {});
      },
      child: Selector<LoginViewModel, UserModel>(
        selector: (context, listenTo) => listenTo.userModel!,
        builder: (context, userModel, child) => Container(
          decoration: BoxDecoration(
              // color: Colors.red,
              border: Border.all(
            width: 1,
            color: const Color(0xffBDBDBD).withOpacity(0.1),
          )),
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: isHover ? 5 : 0,
            animationDuration: const Duration(seconds: 1),
            borderRadius: BorderRadius.circular(15),
            shadowColor: const Color(0xff64CFF9),
            color: const Color(0xff1B2028),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "User Info : ",
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Username : ",
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          userModel.userName,
                          style: const TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Password : ",
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MouseRegion(
                            onEnter: (event) {
                              showPass = true;
                              setState(() {});
                            },
                            onExit: (event) {
                              showPass = false;
                              setState(() {});
                            },
                            child: Material(
                              shadowColor: const Color(0xff64CFF9),
                              color: Colors.transparent,
                              child: Text(
                                getPass(userModel.userPass, showPass),
                                style: const TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "User Bio : ",
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          userModel.userBio,
                          style: const TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tracer ID : ",
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            userModel.accountID.toString(),
                            style: const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getPass(String _password, bool _showPass) {
    return _showPass
        ? _password
        : _password.replaceRange(0, _password.length, "*" * _password.length);
  }
}
