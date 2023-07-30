import 'package:crypto_statistics/model/live_market_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveMarketTable extends StatelessWidget {
  const LiveMarketTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<LiveModel> _liveModelList = [
      LiveModel(
          coinName: "Bitcoin",
          coinLogo: "assets/icons/btc_dashboard.svg",
          change: 12,
          marketCap: 3.56,
          price: 48203,
          volumn: 65.20),
      LiveModel(
          coinName: "Ethereum",
          coinLogo: "assets/icons/eth_dashboard.svg",
          change: 12,
          marketCap: 1.56,
          price: 8203,
          volumn: 6.20),
      LiveModel(
          coinName: "Litcoin",
          coinLogo: "assets/icons/ltc_dashboard.svg",
          change: 2,
          marketCap: 0.56,
          price: 203,
          volumn: 1.20),
    ];
    return SizedBox(
      // color: Colors.red,
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
              "",
              style: TextStyle(color: Color(0xff9E9E9E)),
            )),
            DataColumn(
                label: Text(
              "Change",
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
          rows: List.generate(_liveModelList.length,
              (index) => _buildDataRow(_liveModelList[index])),
        ),
      ),
    );
  }

  DataRow _buildDataRow(LiveModel _model) => DataRow(cells: [
        DataCell(Text(
          _model.coinName,
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(SvgPicture.asset(_model.coinLogo)),
        DataCell(Text(
          "+ ${_model.change}",
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          "\$ ${_model.marketCap}M",
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          "\$ ${_model.volumn}M",
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          "\$ ${_model.price}",
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
      ]);
}
