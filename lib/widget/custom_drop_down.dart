import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {Key? key,
      required this.items,
      required this.onChange,
      required this.selectedValue,
      this.customPadding})
      : super(key: key);
  final List<String> items;
  final Function(String?)? onChange;
  final String selectedValue;
  final EdgeInsets? customPadding;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;
  // final List<String> svgPictures = [
  //   "assets/icons/btc_dashboard.svg",
  //   "assets/icons/eth_dashboard.svg",
  //   "assets/icons/ltc_dashboard.svg",
  //   "assets/icons/sol_dashboard.svg",
  //   "assets/icons/.svg",
  // ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.customPadding ?? const EdgeInsets.all(8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          // enableFeedback: true,

          buttonPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          buttonDecoration: BoxDecoration(
              color: const Color(0xff31353F),
              borderRadius: BorderRadius.circular(5)),
          style: const TextStyle(color: Color(0xffFFFFFF)),
          dropdownDecoration: BoxDecoration(
              color: const Color(0xff1B2028),
              borderRadius: BorderRadius.circular(5)),
          items: widget.items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          autofocus: true,
          value: widget.selectedValue,
          onChanged: widget.onChange,
        ),
      ),
    );
  }

  // List<DropdownMenuItem<dynamic>> getCoinList() {
  //   List<DropdownMenuItem> coinList = [];
  //   coinList.add(
  //     DropdownMenuItem(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SvgPicture.asset("assets/icons/btc_dashboard.svg"),
  //           const Text("BTC"),
  //         ],
  //       ),
  //     ),
  //   );
  //   coinList.add(
  //     DropdownMenuItem(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SvgPicture.asset("assets/icons/eth_dashboard.svg"),
  //           const Text("ETH"),
  //         ],
  //       ),
  //     ),
  //   );
  //   coinList.add(
  //     DropdownMenuItem(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SvgPicture.asset("assets/icons/ltc_dashboard.svg"),
  //           const Text("LTC"),
  //         ],
  //       ),
  //     ),
  //   );
  //   coinList.add(
  //     DropdownMenuItem(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SvgPicture.asset("assets/icons/sol_dashboard.svg"),
  //           const Text("SOL"),
  //         ],
  //       ),
  //     ),
  //   );
  //   coinList.add(
  //     DropdownMenuItem(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SvgPicture.asset("assets/icons/binance_dashboard.svg"),
  //           const Text("BNB"),
  //         ],
  //       ),
  //     ),
  //   );
  //   return coinList;
  // }
}
