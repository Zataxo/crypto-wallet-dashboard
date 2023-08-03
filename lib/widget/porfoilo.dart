import 'package:crypto_statistics/model/portfoilo_model.dart';
import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/view_model/dashboard_screen_view_model.dart';
import 'package:crypto_statistics/widget/loading_dashboard_widgets.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PersonalAccounts extends StatefulWidget {
  const PersonalAccounts({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalAccounts> createState() => _PersonalAccountsState();
}

class _PersonalAccountsState extends State<PersonalAccounts> {
  @override
  Widget build(BuildContext context) {
    // final x = Provider.of<DashboardViewModel>(context).getUserPortfoilo();
    return Consumer<DashboardViewModel>(
        builder: (context, dashboardViewModel, child) {
      // dashboardViewModel.getUserPortfoilo();

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
              child: dashboardViewModel.state != LoadingState.loaded ||
                      dashboardViewModel.getCoins().isEmpty
                  ? const LoadingDashboard()
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: dashboardViewModel.getCoins().length,
                      itemBuilder: (context, index) => _buildMyPortfoilo(
                          dashboardViewModel.getCoins()[index], index)),
            )
          ],
        ),
      );
    });
  }

  Widget _buildMyPortfoilo(CoinModel _coinModel, int index) {
    //    CurrencyFormatterSettings noSetting = CurrencyFormatterSettings(
    //   symbol: '',
    //   symbolSide: SymbolSide.left,
    //   thousandSeparator: '.',
    //   decimalSeparator: ',',
    //   symbolSeparator: ' ',
    // );
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            // width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff31353F)),
            child: SvgPicture.asset(_coinModel.coinLogo),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _coinModel.coinName,
                  style: const TextStyle(
                      color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
                ),
                Text(
                  CurrencyFormatter.format(
                      context.read<DashboardViewModel>().getPriceInDollar(
                          _coinModel.coinName, _coinModel.coinAmount.toInt()),
                      CurrencyFormatterSettings.usd),
                  style: const TextStyle(color: Color(0xff9E9E9E)),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "${_coinModel.coinAmount} ${_coinModel.coinShortcut.toUpperCase()}",
            style: const TextStyle(
                color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
