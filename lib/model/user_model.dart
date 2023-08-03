class UserModel {
  BigInt accountID;
  String userName;
  String userBio;
  String userPass;
  String userVisaCard;
  List<dynamic> coinsList;
  List<dynamic> amountsList;
  List<int> userID;
  UserModel({
    required this.accountID,
    required this.userName,
    required this.userBio,
    required this.userPass,
    required this.userVisaCard,
    required this.coinsList,
    required this.amountsList,
    required this.userID,
  });
}
