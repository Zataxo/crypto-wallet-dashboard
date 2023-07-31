import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/view_model/dashboard_screen_view_model.dart';
import 'package:crypto_statistics/widget/custom_drop_down.dart';
import 'package:crypto_statistics/widget/custom_text_from_field.dart';
import 'package:crypto_statistics/widget/custome_button.dart';
import 'package:crypto_statistics/widget/loading_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTransactionDialog extends StatefulWidget {
  const NewTransactionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<NewTransactionDialog> createState() => _NewTransactionDialogState();
}

class _NewTransactionDialogState extends State<NewTransactionDialog> {
  final List<String> coinsList = [
    "Select coin",
    "BTC",
    "ETH",
    "LTC",
    "SOL",
    "BNB"
  ];
  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  final _sender = TextEditingController();
  final _receiver = TextEditingController();
  final _amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: size.height * 0.5,
        width: size.width * 0.4,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff1B2028),
        ),
        child: context.watch<DashboardViewModel>().state ==
                    LoadingState.loading &&
                context.watch<DashboardViewModel>().state != LoadingState.intial
            ? const Center(child: LoadingDialogs())
            : _buildSendMoneyForm(context),
      ),
    );
  }

  Form _buildSendMoneyForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Transfer Money",
                style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xffFFFFFF),
                  ))
            ],
          ),
          const Divider(
            color: Color(0xff9E9E9E),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: CustomTextFormField(
                  controller: _sender,
                  fillColor: const Color(0xff31353F),
                  hintText: "Sender Tracer ID",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Sender ID";
                    }
                    return null;
                  },
                  inputColor: const Color(0xffFFFFFF),
                  customPadding: const EdgeInsets.only(right: 4.0),
                  hintTextStyle:
                      const TextStyle(color: Color(0xffFFFFFF), fontSize: 14),
                )),
                Expanded(
                    child: CustomTextFormField(
                  controller: _receiver,
                  inputColor: const Color(0xffFFFFFF),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Receiver ID";
                    }
                    return null;
                  },
                  fillColor: const Color(0xff31353F),
                  hintText: "Receiver Tracer ID",
                  customPadding: const EdgeInsets.only(left: 4.0),
                  hintTextStyle:
                      const TextStyle(color: Color(0xffFFFFFF), fontSize: 14),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                    items: coinsList,
                    customPadding: const EdgeInsets.only(right: 4.0),
                    selectedValue: selectedValue ?? coinsList[0],
                    onChange: (String? _val) {
                      if (_val != null) {
                        selectedValue = _val;
                      }
                      setState(() {});
                      // print(selectedValue);
                    },
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    controller: _amount,
                    fillColor: const Color(0xff31353F),
                    inputColor: const Color(0xffFFFFFF),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Valid Amount";
                      }
                      return null;
                    },
                    hintText: "Amount",
                    customPadding: const EdgeInsets.only(left: 4.0),
                    hintTextStyle:
                        const TextStyle(color: Color(0xffFFFFFF), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                  buttonName: "Transfer",
                  buttonColor: const Color(0xff1ECB4F),
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xffFFFFFF),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // wait for view model
                      print("Before Set Loading");
                      context
                          .read<DashboardViewModel>()
                          .setLoadingState(LoadingState.loading);
                      print("Set loading");
                      Future.delayed(const Duration(seconds: 4), () {
                        context
                            .read<DashboardViewModel>()
                            .setLoadingState(LoadingState.loaded);
                      });
                      print("Loaded");
                    }
                  },
                )),
                Expanded(
                    child: CustomButton(
                  buttonName: "Cancel",
                  buttonColor: const Color(0xffF46D22),
                  icon: const Icon(
                    Icons.cancel,
                    color: Color(0xffFFFFFF),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
