import 'dart:developer';

import 'package:crypto_statistics/model/livemarket_model.dart';
import 'package:crypto_statistics/model/portfoilo_model.dart';
import 'package:crypto_statistics/model/user_model.dart';
import 'package:crypto_statistics/utils/contract_linking.dart';
import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/utils/uitl_functions.dart';
import 'package:crypto_statistics/view_model/login_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DashboardViewModel extends ChangeNotifier {
  List<LiveMarketModel> _liveMarketList = [];
  final List<CoinModel> _userCoinList = [];
  List<CoinModel> _filteredList = [];
  ContractLinking link = ContractLinking();
  UserModel? userModel;
  LoadingState state = LoadingState.intial;

  DashboardViewModel(context) {
    fetchUserPortfolo(context);
    fetchLiveData();
  }
  Future<void> fetchLiveData() async {
    setLoadingState(LoadingState.loading);
    final http.Response response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"));
    if (response.statusCode == 200) {
      // log(response.body);
      log("Fetched Successfully");
      setLiveData(liveMarketModelFromJson(response.body));
      setLoadingState(LoadingState.loaded);
    }
  }

  Future<void> setLiveData(List<LiveMarketModel> data) async {
    _liveMarketList = data;
    notifyListeners();
  }

  List<LiveMarketModel> getLiveMarket() {
    return _liveMarketList;
  }

  Future<void> fetchUserPortfolo(BuildContext ctx) async {
    print("Fetching from portfoilo");
    print("Fetching from portfoilo");
    print("Fetching from portfoilo");
    _userCoinList.clear();
    _filteredList.clear();
    setLoadingState(LoadingState.loading);
    await link.intialize();
    // Fetching u_id from userModel
    userModel = ctx.read<LoginViewModel>().userModel;
    try {
      final newUserModel = await link.client.call(
          contract: link.contract,
          function: link.getUserModel,
          params: [userModel!.accountID]);
      ctx.read<LoginViewModel>().userModel = UserModel(
          accountID: newUserModel[0][0],
          userName: newUserModel[0][2],
          userBio: newUserModel[0][3],
          userPass: newUserModel[0][4],
          userVisaCard: newUserModel[0][5],
          coinsList: newUserModel[0][6],
          amountsList: newUserModel[0][7],
          userID: newUserModel[0][8]);
      print(ctx.read<LoginViewModel>().userModel!.amountsList.toString());
      log(newUserModel.toString());
      // print(newUserModel[0][1]);

      for (var i = 0; i < userModel!.coinsList.length; i++) {
        _userCoinList.add(CoinModel(
            coinName: getCoinFullName(userModel!.coinsList[i]),
            coinShortcut: userModel!.coinsList[i],
            coinAmount: userModel!.amountsList[i],
            coinLogo: getCoinLogo(userModel!.coinsList[i])));
      }
      setLoadingState(LoadingState.loaded);
      notifyListeners();

      setCoinList();

      // notifyListeners();

    } catch (e) {
      log(e.toString());
    }
  }

  void setLoadingState(LoadingState value) {
    state = value;
    notifyListeners();
  }

  void setCoinList() {
    _filteredList = _userCoinList;
    notifyListeners();
  }

  List<CoinModel> getCoins() {
    return _filteredList;
  }

  void logOut() {
    print("Cleared");
    print("Cleared");
    print("Cleared");
    _userCoinList.clear();
    _filteredList.clear();
    notifyListeners();
  }
}
