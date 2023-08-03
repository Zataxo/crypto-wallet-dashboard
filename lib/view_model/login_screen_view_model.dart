import 'dart:developer';

import 'package:crypto_statistics/model/user_model.dart';
import 'package:crypto_statistics/utils/contract_linking.dart';
import 'package:crypto_statistics/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:web3dart/web3dart.dart';

class LoginViewModel extends ChangeNotifier {
  late int tracerNo;
  UserModel? userModel;
  bool successfulLogin = false;
  LoadingState state = LoadingState.intial;
  ContractLinking link = ContractLinking();
  // DashboardViewModel dashboardViewModel = DashboardViewModel();

  void setLoadingState(LoadingState value) {
    state = value;
    notifyListeners();
  }

  Future<void> singIn(
      BigInt _tracerId, String _userName, String _userPass) async {
    setLoadingState(LoadingState.loading);

    // initlaize the link provider
    await link.intialize();
    //

    // BigInt _tracerID = BigInt.from(_tracerId);
    try {
      final response = await link.client.call(
        contract: link.contract,
        function: link.loginFunction,
        params: [_tracerId, _userName, _userPass],
      );

      if (response[1] == true) {
        // setting up user Logined Model
        // log(response[0]);
        print(response[0]);
        userModel = UserModel(
            accountID: response[0][0],
            userName: response[0][2],
            userBio: response[0][3],
            userPass: response[0][4],
            userVisaCard: response[0][5],
            coinsList: response[0][6],
            amountsList: response[0][7],
            userID: response[0][8]);
        setLoadingState(LoadingState.loaded);
        successfulLogin = true;

        print(userModel);
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  Future<void> signUp(String _userName, String _userBio, String _userPass,
      String _userVisa) async {
    setLoadingState(LoadingState.loading);
    await link.intialize();
    try {
      await link.client.sendTransaction(
          link.credintails,
          Transaction.callContract(
              contract: link.contract,
              function: link.signUp,
              parameters: [_userName, _userBio, _userPass, _userVisa]),
          chainId: 1337);
      final response = await link.client
          .call(contract: link.contract, function: link.totalUsers, params: []);
      if (response.isNotEmpty) {
        tracerNo = (response[0].toInt() - 1);
        print(tracerNo);
        print(response[0]);
        print("--------");
        print(response);
        setLoadingState(LoadingState.loaded);
        notifyListeners();
      } else {
        print("kljhgfghjkl;kjhgfghjklkfghjkl");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
