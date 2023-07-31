import 'package:crypto_statistics/model/coins_statistics_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalAccounts extends StatefulWidget {
  const PersonalAccounts({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalAccounts> createState() => _PersonalAccountsState();
}

class _PersonalAccountsState extends State<PersonalAccounts> {
  bool onHover = false;
  // int itemToBeAffected = -1;
  @override
  Widget build(BuildContext context) {
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
          coinValue: 3.045,
          increment: false,
          incrementValue: 0.25),
      CoinsStatistics(
          coinLogo: "assets/icons/eth_dashboard.svg",
          coinName: "Ethereum",
          coinShortcut: "ETH",
          lineColor: const Color(0xff3A6FF8),
          priceInUSD: 14500,
          coinValue: 3.045,
          increment: true,
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
          coinValue: 3.045,
          increment: true,
          incrementValue: 0.25),
    ];
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 15, bottom: 5, right: 5, top: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff1B2028),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Portfolio",
            style: TextStyle(
                color: Color(0xffE4E4E4), fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: statisticsList.length,
                itemBuilder: (context, index) =>
                    _buildMyPortfoilo(statisticsList[index])),
          )
        ],
      ),
    );
  }

  Widget _buildMyPortfoilo(CoinsStatistics _statistucs) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff31353F)),
            child: SvgPicture.asset(_statistucs.coinLogo),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _statistucs.coinName,
                  style: const TextStyle(
                      color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${_statistucs.priceInUSD}",
                  style: const TextStyle(color: Color(0xff9E9E9E)),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _statistucs.increment
                    ? " + ${_statistucs.incrementValue} %"
                    : " - ${_statistucs.incrementValue} %",
                style: TextStyle(
                    color: _statistucs.increment
                        ? const Color(0xff1ECB4F)
                        : const Color(0xffF46D22)),
              ),
              Text(
                "${_statistucs.coinValue} ${_statistucs.coinShortcut}",
                style: const TextStyle(
                    color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
