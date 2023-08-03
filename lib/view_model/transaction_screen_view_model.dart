import 'dart:developer';

import 'package:crypto_statistics/model/transaction_model.dart';
import 'package:crypto_statistics/utils/contract_linking.dart';
import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/view_model/login_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class TransactionViewModel extends ChangeNotifier {
  final List<TransactionModel> _userTransactions = [];
  List<TransactionModel> _filteredList = [];
  ContractLinking link = ContractLinking();
  // BigInt? tracerID;
  LoadingState state = LoadingState.intial;
  TransactionViewModel(context) {
    fetchTransactions(context);
  }

  Future<void> fetchTransactions(BuildContext ctx) async {
    print("Fetchin from transactions");
    print("Fetchin from transactions");
    print("Fetchin from transactions");
    _userTransactions.clear();
    BigInt totalTransaction;
    await link.intialize();
    setLoadingState(LoadingState.loading);
    // tracerID = ctx.read<LoginViewModel>().userModel!.accountID;
    //intilaize a connection with blockchain
    try {
      final response = await link.client.call(
          contract: link.contract,
          function: link.totalTransactions,
          params: []);
      totalTransaction = response[0];
      // print("Total Transactions :");
      // print(totalTransaction);
      // print("Total Transactions :");
      for (var i = 0; i < totalTransaction.toInt(); i++) {
        final temp = await link.client.call(
            contract: link.contract,
            function: link.transactionsMap,
            params: [BigInt.from(i)]);
        _userTransactions.add(TransactionModel(
            sender: temp[0],
            receiver: temp[1],
            amount: temp[2],
            currency: temp[3],
            tType: temp[4]));
        // print(temp);
        // print(temp[0]);
        // print(temp[1]);
        // print(temp[2]);
        // print(temp[3]);
        // print(temp[4]);
      }
      setLoadingState(LoadingState.loaded);
      setTransactionList();
      // print(state);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deposit(BuildContext ctx, BigInt _receiver, BigInt _amount,
      String _currency) async {
    setLoadingState(LoadingState.loading);
    try {
      await link.client.sendTransaction(
          link.credintails,
          Transaction.callContract(
              contract: link.contract,
              function: link.depositCoin,
              parameters: [_receiver, _amount, _currency]),
          chainId: 1337);

      fetchTransactions(ctx);
      setLoadingState(LoadingState.loaded);
      setLoadingState(LoadingState.intial);

      // fetchTransactions(ctx);

    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> transferFund(BuildContext ctx, BigInt _sender, BigInt _receiver,
      BigInt _amount, String _currency) async {
    setLoadingState(LoadingState.loading);
    try {
      await link.client.sendTransaction(
          link.credintails,
          Transaction.callContract(
              contract: link.contract,
              function: link.transferFund,
              parameters: [_sender, _receiver, _amount, _currency]),
          chainId: 1337);
      setLoadingState(LoadingState.loaded);

      fetchTransactions(ctx);
      setLoadingState(LoadingState.intial);
    } catch (e) {
      log(e.toString());
    }
  }

  void setLoadingState(LoadingState value) {
    state = value;
    notifyListeners();
  }

  void setTransactionList() {
    _filteredList = _userTransactions;
    notifyListeners();
  }

  String getTransactionSender(BigInt _sender, BuildContext ctx) {
    if (_sender == BigInt.from(1000)) {
      return "Owner";
    } else {
      return ctx.read<LoginViewModel>().userModel!.userName;
    }
  }

  List<TransactionModel> getUserTransaction(BigInt _senderID, bool _isRecent) {
    const depositType = "deposit";
    List<TransactionModel> _returnedList = [];
    if (_isRecent == true) {
      _returnedList.addAll(_filteredList
          .where((element) =>
              element.tType.toLowerCase() == depositType &&
              element.receiver == _senderID)
          .take(5));
      _returnedList.addAll(_filteredList
          .where((element) =>
              element.tType.toLowerCase() != depositType &&
              element.sender == _senderID)
          .take(5));
      return _returnedList;
    } else {
      _returnedList.addAll(_filteredList.where((element) =>
          element.tType.toLowerCase() == depositType &&
          element.receiver == _senderID));
      _returnedList.addAll(_filteredList.where((element) =>
          element.tType.toLowerCase() != depositType &&
          element.sender == _senderID));
      return _returnedList;
    }
  }
}

  //  Future<void> depositCoin(
  //     BigInt _uID, BigInt _amount, String _currency) async {
  //   try {
  //     await link.client.sendTransaction(
  //         link.credintails,
  //         Transaction.callContract(
  //           contract: link.contract,
  //           function: link.depositCoin,
  //           parameters: [_uID, _amount, _currency],
  //         ),
  //         chainId: 1337);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }