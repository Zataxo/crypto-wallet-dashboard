import 'package:crypto_statistics/model/livemarket_model.dart';
import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/view_model/dashboard_screen_view_model.dart';
import 'package:crypto_statistics/widget/loading_dashboard_widgets.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intil;

class LiveMarketTable extends StatefulWidget {
  const LiveMarketTable({
    Key? key,
  }) : super(key: key);

  @override
  State<LiveMarketTable> createState() => _LiveMarketTableState();
}

class _LiveMarketTableState extends State<LiveMarketTable> {
  CurrencyFormatterSettings noSetting = CurrencyFormatterSettings(
    symbol: '',
    symbolSide: SymbolSide.left,
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
        builder: (context, dashboardViewModel, child) {
      return dashboardViewModel.state != LoadingState.loaded ||
              dashboardViewModel.getLiveMarket().isEmpty
          ? const LoadingDashboard()
          : Container(
              // color: Colors.red,
              padding: const EdgeInsets.all(12.0),
              width: double.infinity,
              child: SingleChildScrollView(
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: 10,
                  columns: const [
                    DataColumn(
                        label: Text(
                      "Coin",
                      style: TextStyle(color: Color(0xff9E9E9E)),
                    )),
                    DataColumn(
                        label: Text(
                      "Icon",
                      style: TextStyle(color: Color(0xff9E9E9E)),
                    )),
                    DataColumn(
                        label: Text(
                      "Daily Change",
                      style: TextStyle(color: Color(0xff9E9E9E)),
                    )),
                    DataColumn(
                        label: Text(
                      "Market Cap",
                      style: TextStyle(color: Color(0xff9E9E9E)),
                    )),
                    DataColumn(
                        label: Text(
                      "24h Volume",
                      style: TextStyle(color: Color(0xff9E9E9E)),
                    )),
                    DataColumn(
                        label: Text(
                      "Price",
                      style: TextStyle(color: Color(0xff9E9E9E)),
                    )),
                  ],
                  rows: List.generate(
                      dashboardViewModel.getLiveMarket().length,
                      (index) => _buildDataRow(
                          dashboardViewModel.getLiveMarket()[index])),
                ),
              ),
            );
    });
  }

  DataRow _buildDataRow(LiveMarketModel _model) => DataRow(cells: [
        DataCell(Text(
          intil.toBeginningOfSentenceCase(_model.symbol)!,
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Image.network(
          _model.image,
          width: 20,
        )),
        DataCell(_model.priceChangePercentage24H > 0
            ? const Icon(
                Icons.arrow_drop_up_outlined,
                color: Color(0xff1ECB4F),
              )
            : const Icon(
                Icons.arrow_drop_down_outlined,
                color: Color(0xffF46D22),
              )),
        DataCell(Text(
          CurrencyFormatter.format(
              _model.marketCap, CurrencyFormatterSettings.usd),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          CurrencyFormatter.format(_model.totalVolume, noSetting),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          CurrencyFormatter.format(
              _model.currentPrice, CurrencyFormatterSettings.usd),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
      ]);
}
