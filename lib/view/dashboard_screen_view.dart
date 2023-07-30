import 'package:crypto_statistics/model/coins_statistics_model.dart';
import 'package:crypto_statistics/widget/dashboard_header.dart';
import 'package:crypto_statistics/widget/live_market.dart';
import 'package:crypto_statistics/widget/porfoilo.dart';
import 'package:crypto_statistics/widget/recent_transaction.dart';
import 'package:crypto_statistics/widget/visa_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({Key? key}) : super(key: key);

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  final _searchable = TextEditingController();
  final List<CoinsStatistics> statisticsList = [
    CoinsStatistics(
        coinLogo: "assets/icons/btc_dashboard.svg",
        coinName: "Bitcoin",
        coinShortcut: "BTC",
        lineColor: const Color(0xff3A6FF8),
        priceInUSD: 54700,
        increment: true,
        coinValue: 3.045,
        incrementValue: 0.25),
    CoinsStatistics(
        coinLogo: "assets/icons/ltc_dashboard.svg",
        coinName: "Litcoin",
        coinShortcut: "LTC",
        lineColor: const Color(0xff64CFF9),
        priceInUSD: 8234,
        increment: false,
        coinValue: 3.045,
        incrementValue: 0.25),
    CoinsStatistics(
        coinLogo: "assets/icons/eth_dashboard.svg",
        coinName: "Ethereum",
        coinShortcut: "ETH",
        lineColor: const Color(0xff3A6FF8),
        priceInUSD: 14500,
        increment: true,
        coinValue: 3.045,
        incrementValue: 0.25),
    CoinsStatistics(
        coinLogo: "assets/icons/sol_dashboard.svg",
        coinName: "Solana",
        coinShortcut: "SOL",
        lineColor: const Color(0xff1ECB4F),
        priceInUSD: 28100,
        coinValue: 3.045,
        increment: false,
        incrementValue: 0.25),
    CoinsStatistics(
        coinLogo: "assets/icons/binance_dashboard.svg",
        coinName: "Binance",
        coinShortcut: "BNB",
        lineColor: const Color(0xffFFC01E),
        priceInUSD: 8100,
        increment: true,
        coinValue: 3.045,
        incrementValue: 0.25),
  ];
  bool onHover = false;
  int itemToBeAffected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff31353F),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: DashboardHeader(
                  title: "Dashboard",
                  search: _searchable,
                )),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: statisticsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            _builCoinsStatistics(statisticsList[index], index),
                      ),
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
                          child: LatestTransactions(),
                        ),
                        Expanded(
                          flex: 4,
                          child: LiveMarket(),
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

  Widget _builCoinsStatistics(CoinsStatistics _statistic, index) {
    return MouseRegion(
      onExit: (event) {
        onHover = false;
        setState(() {});
        print(onHover);
      },
      onEnter: (event) {
        onHover = true;
        itemToBeAffected = index;
        setState(() {
          print(onHover);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xff1B2028)),
        child: Material(
          color: const Color(0xff1B2028),
          elevation: onHover && itemToBeAffected == index ? 5 : 0,
          animationDuration: const Duration(seconds: 2),
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
                      child: SvgPicture.asset(_statistic.coinLogo),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _statistic.coinName,
                            style: const TextStyle(
                                color: Color(0xffFFFFFF),
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _statistic.coinShortcut,
                              style: const TextStyle(color: Color(0xff9E9E9E)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Icon(
                      _statistic.increment
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: _statistic.increment
                          ? const Color(0xff1ECB4F)
                          : const Color(0xffF46D22),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$  ${_statistic.priceInUSD}",
                            style: const TextStyle(
                                color: Color(0xffFFFFFF),
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _statistic.increment
                                  ? "+ ${_statistic.incrementValue}"
                                  : "-${_statistic.incrementValue} ",
                              style: TextStyle(
                                  color: _statistic.increment
                                      ? const Color(0xff1ECB4F)
                                      : const Color(0xffF46D22),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/line.svg",
                            color: _statistic.lineColor,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
