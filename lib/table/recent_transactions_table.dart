import 'package:crypto_statistics/model/transaction_model.dart';
import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/utils/uitl_functions.dart';
import 'package:crypto_statistics/view_model/login_screen_view_model.dart';
import 'package:crypto_statistics/view_model/transaction_screen_view_model.dart';
import 'package:crypto_statistics/widget/error_handling.dart';
import 'package:crypto_statistics/widget/loading_dashboard_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RecentTransactionsTable extends StatefulWidget {
  const RecentTransactionsTable({
    Key? key,
    required this.isRecent,
  }) : super(key: key);
  final bool isRecent;

  @override
  State<RecentTransactionsTable> createState() =>
      _RecentTransactionsTableState();
}

class _RecentTransactionsTableState extends State<RecentTransactionsTable> {
  late final transactionViewModel = Provider.of<TransactionViewModel>(context);
  @override
  Widget build(BuildContext context) {
    BigInt accountID = context.read<LoginViewModel>().userModel!.accountID;
    List<TransactionModel> transactionsList = transactionViewModel
        .getUserTransaction(accountID, widget.isRecent ? true : false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: transactionViewModel.state == LoadingState.loading &&
              transactionViewModel
                  .getUserTransaction(accountID, widget.isRecent ? true : false)
                  .isEmpty
          ? const LoadingDashboard()
          : transactionViewModel.state == LoadingState.loaded &&
                  transactionViewModel
                      .getUserTransaction(
                          accountID, widget.isRecent ? true : false)
                      .isEmpty
              ? const ErrorHandling()
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
                        DataColumn(
                            label: Text(
                          "Type",
                          style: TextStyle(color: Color(0xff9E9E9E)),
                        )),
                      ],
                      rows: List.generate(
                          transactionsList.length,
                          (index) => _buildDataRow(
                              transactionsList[index], index, context)),
                    ),
                  ),
                ),
    );
  }

  DataRow _buildDataRow(TransactionModel _model, int index, BuildContext ctx) =>
      DataRow(cells: [
        DataCell(Text(
          (index + 1).toString(),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          transactionViewModel.getTransactionSender(_model.sender, ctx),
          // _model.sender.toString(),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          _model.receiver.toString(),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          _model.amount.toString(),
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(SvgPicture.asset(getCoinLogo(_model.currency))),
        DataCell(Text(
          _model.currency,
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
        DataCell(Text(
          _model.tType,
          style: const TextStyle(color: Color(0xffFFFFFF)),
        )),
      ]);
}
