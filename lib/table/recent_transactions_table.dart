import 'package:crypto_statistics/model/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentTransactionsTable extends StatelessWidget {
  const RecentTransactionsTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Transactions> _transactionsList = [
      Transactions(
          sender: "Hassan Ismat",
          receiver: "Ahmed Taha",
          senderAddress: "0x05675436k4",
          coinImg: "assets/icons/btc_dashboard.svg",
          receiverAddress: "0x038ryd893d",
          amountTransfered: 3.5,
          coinTransfered: "BTC"),
      Transactions(
          sender: "Hassan Ismat",
          receiver: "Anna Haleem",
          senderAddress: "0x05675436k4",
          coinImg: "assets/icons/eth_dashboard.svg",
          receiverAddress: "0x038ryd893d",
          amountTransfered: 0.5,
          coinTransfered: "ETH"),
      Transactions(
          sender: "Hassan Ismat",
          receiver: "Youmna Ahmed",
          senderAddress: "0x05675436k4",
          receiverAddress: "0x045Bg63whs28d",
          coinImg: "assets/icons/ltc_dashboard.svg",
          amountTransfered: 2.5,
          coinTransfered: "LTC"),
      Transactions(
          sender: "Hassan Ismat",
          receiver: "Ahmed Taha",
          senderAddress: "0x05675436k4",
          coinImg: "assets/icons/binance_dashboard.svg",
          receiverAddress: "0x038ryd893d",
          amountTransfered: 1.5,
          coinTransfered: "BNB"),
      Transactions(
          sender: "Hassan Ismat",
          receiver: "John Eric",
          senderAddress: "0x05675436k4",
          receiverAddress: "0x0c230edkmx",
          coinImg: "assets/icons/sol_dashboard.svg",
          amountTransfered: 3.5,
          coinTransfered: "SOL"),
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
              "*",
              style: TextStyle(color: Color(0xff9E9E9E)),
            )),
            DataColumn(
                label: Text(
              "Sender",
              style: TextStyle(color: Color(0xff9E9E9E)),
            )),
            DataColumn(
                label: Text(
              "Receiver",
              style: TextStyle(color: Color(0xff9E9E9E)),
            )),
            DataColumn(
                label: Text(
              "Amount",
              style: TextStyle(color: Color(0xff9E9E9E)),
            )),
            DataColumn(
                label: Text(
              " ",
              style: TextStyle(color: Color(0xff9E9E9E)),
            )),
            DataColumn(
                label: Text(
              "Coin",
              style: TextStyle(color: Color(0xff9E9E9E)),
            )),
          ],
          rows: List.generate(_transactionsList.length,
              (index) => _buildDataRow(_transactionsList[index], index)),
        ),
      ),
    );
  }

  DataRow _buildDataRow(Transactions _model, int index) => DataRow(cells: [
        DataCell(Text(
          (index + 1).toString(),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          _model.sender,
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          _model.receiver,
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          _model.amountTransfered.toString(),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(SvgPicture.asset(_model.coinImg)),
        DataCell(Text(
          _model.coinTransfered,
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
      ]);
}
