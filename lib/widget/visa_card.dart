import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/view_model/dashboard_screen_view_model.dart';
import 'package:crypto_statistics/widget/loading_dashboard_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VisaCard extends StatefulWidget {
  const VisaCard({
    Key? key,
  }) : super(key: key);

  @override
  State<VisaCard> createState() => _VisaCardState();
}

bool _showPass = false;

class _VisaCardState extends State<VisaCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardViewModel, child) => MouseRegion(
        onEnter: (event) {
          _showPass = true;
          setState(() {});
        },
        onExit: (event) {
          _showPass = false;
          setState(() {});
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15, bottom: 5, right: 5),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color(0xff1573FE),
              borderRadius: BorderRadius.circular(15)),
          child: dashboardViewModel.state != LoadingState.loaded ||
                  dashboardViewModel.userModel!.userVisaCard == ""
              ? const LoadingDashboard()
              : Material(
                  color: const Color(0xff1573FE),
                  elevation: _showPass == true ? 5 : 0,
                  animationDuration: const Duration(seconds: 1),
                  borderRadius: BorderRadius.circular(15),
                  shadowColor: const Color(0xff64CFF9),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Credit Card",
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.bold),
                            ),
                            SvgPicture.asset(
                              "assets/icons/chip.svg",
                            )
                          ],
                        ),
                        Text(
                          getPass(dashboardViewModel.userModel!.userVisaCard,
                              _showPass),
                          style: const TextStyle(color: Color(0xffFFFFFF)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dashboardViewModel.userModel!.userName,
                              style: const TextStyle(color: Color(0xffFFFFFF)),
                            ),
                            const Text(
                              "VISA",
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ]),
                ),
        ),
      ),
    );
  }

  String getPass(String _password, bool _showPass) {
    return _showPass ? _password : _password.replaceRange(5, 10, "*" * 5);
  }
}
