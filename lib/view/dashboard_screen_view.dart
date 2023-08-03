import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/view_model/dashboard_screen_view_model.dart';
import 'package:crypto_statistics/widget/dashboard_header.dart';
import 'package:crypto_statistics/widget/live_market.dart';
import 'package:crypto_statistics/widget/loading_dashboard_widgets.dart';
import 'package:crypto_statistics/widget/porfoilo.dart';
import 'package:crypto_statistics/widget/recent_transaction.dart';
import 'package:crypto_statistics/widget/visa_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({Key? key}) : super(key: key);

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  bool onHover = false;
  int itemToBeAffected = -1;
  late final dashboardViewModel = Provider.of<DashboardViewModel>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff31353F),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
                flex: 1,
                child: DashboardHeader(
                  title: "Dashboard",
                )),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Consumer<DashboardViewModel>(
                          builder: (context, dashboardViewModel, child) {
                        return ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              _builCoinsStatistics(index),
                        );
                      }),
                    )
                  ],
                )),
            Expanded(
              flex: 7,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: const [
                        Expanded(
                          flex: 3,
                          child: VisaCard(),
                        ),
                        Expanded(
                          flex: 7,
                          child: PersonalAccounts(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: const [
                        Expanded(
                          flex: 8,
                          child: LiveMarket(),
                        ),
                        Expanded(
                          flex: 4,
                          child: LatestTransactions(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builCoinsStatistics(index) {
    return MouseRegion(
        onExit: (event) {
          onHover = false;
          setState(() {});
          // print(onHover);
        },
        onEnter: (event) {
          onHover = true;
          itemToBeAffected = index;
          setState(() {
            // print(onHover);
          });
        },
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff1B2028)),
          child: dashboardViewModel.state != LoadingState.loaded ||
                  dashboardViewModel.getCoins().isEmpty
              ? const LoadingDashboard()
              : Material(
                  color: const Color(0xff1B2028),
                  elevation: onHover && itemToBeAffected == index ? 5 : 0,
                  animationDuration: const Duration(seconds: 1),
                  borderRadius: BorderRadius.circular(15),
                  shadowColor: const Color(0xff64CFF9),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff31353F)),
                              child: SvgPicture.asset(dashboardViewModel
                                  .getCoins()[index]
                                  .coinLogo),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dashboardViewModel
                                        .getCoins()[index]
                                        .coinName,
                                    style: const TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(
                                      dashboardViewModel
                                          .getCoins()[index]
                                          .coinShortcut,
                                      style: const TextStyle(
                                          color: Color(0xff9E9E9E)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              Text(
                                dashboardViewModel
                                    .getCoins()[index]
                                    .coinAmount
                                    .toString(),
                                style: const TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/line.svg",
                                      color: index == 0
                                          ? const Color(0xff64CFF9)
                                          : index == 1
                                              ? const Color(0xff3A6FF8)
                                              : index == 2
                                                  ? const Color(0xff1ECB4F)
                                                  : index == 3
                                                      ? const Color(0xff3A6FF8)
                                                      : const Color(0xffFFC01E),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
