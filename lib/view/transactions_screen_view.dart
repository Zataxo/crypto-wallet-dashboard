import 'package:crypto_statistics/table/recent_transactions_table.dart';
import 'package:crypto_statistics/widget/dashboard_header.dart';
import 'package:crypto_statistics/widget/table_header.dart';
import 'package:flutter/material.dart';

class TransactionsScreenView extends StatefulWidget {
  const TransactionsScreenView({Key? key}) : super(key: key);

  @override
  State<TransactionsScreenView> createState() => _TransactionsScreenViewState();
}

class _TransactionsScreenViewState extends State<TransactionsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff31353F),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
                flex: 1, child: DashboardHeader(title: "Transactions")),
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(width: 1, color: const Color(0xff1B2028)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Expanded(flex: 1, child: TableHeader()),
                    Expanded(
                      flex: 9,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   width: 1,
                          //   color: const Color(0xff1B2028)
                          //   ,
                          // ),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: RecentTransactionsTable(
                              isRecent: false,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
