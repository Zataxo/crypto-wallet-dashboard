class TransactionModel {
  BigInt sender;
  BigInt receiver;
  BigInt amount;
  String currency;
  String tType;
  TransactionModel({
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.currency,
    required this.tType,
  });
}
