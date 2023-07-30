import 'package:crypto_statistics/table/live_market_table.dart';
import 'package:flutter/material.dart';

class LiveMarket extends StatelessWidget {
  const LiveMarket({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: const Color(0xff1B2028),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            flex: 0,
            child: Text(
              "Live Market",
              style: TextStyle(
                  color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 1, child: LiveMarketTable())
        ],
      ),
    );
  }
}
