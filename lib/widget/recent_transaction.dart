import 'package:crypto_statistics/table/recent_transactions_table.dart';
import 'package:flutter/material.dart';

class LatestTransactions extends StatelessWidget {
  const LatestTransactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15, left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff1B2028),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            flex: 0,
            child: Text(
              "Recent Transaction",
              style: TextStyle(
                  color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 1, child: RecentTransactionsTable())
        ],
      ),
    );
  }
}
