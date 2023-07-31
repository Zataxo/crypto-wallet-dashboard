import 'package:crypto_statistics/dialog/despoit_dialog.dart';
import 'package:crypto_statistics/dialog/new_transaction_dialog.dart';
import 'package:crypto_statistics/widget/custom_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableHeader extends StatefulWidget {
  const TableHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<TableHeader> {
  final _searchable = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xffBDBDBD).withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CustomTextFormField(
                controller: _searchable,
                fillColor: const Color(0xff1B2028),
                inputColor: const Color(0xffFFFFFF),
                hintText: "Search Transaction",
                hintTextStyle: const TextStyle(
                  color: Color(0xff9E9E9E),
                )),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const DepositDialog());
              },
              icon: SvgPicture.asset(
                "assets/icons/deposit.svg",
                color: const Color(0xffFFFFFF),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const NewTransactionDialog());
              },
              icon: const Icon(
                Icons.add,
                color: Color(0xffFFFFFF),
              )),
        ],
      ),
    );
  }
}
