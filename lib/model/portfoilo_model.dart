class UserPortfoiloModel {
  BigInt accountID;
  List<CoinModel> coinNames;

  UserPortfoiloModel({required this.accountID, required this.coinNames});
}

class CoinModel {
  String coinName;
  String coinShortcut;
  String coinLogo;
  BigInt coinAmount;
  CoinModel({
    required this.coinName,
    required this.coinShortcut,
    required this.coinAmount,
    required this.coinLogo,
  });
}
