class Transactions {
  String sender;
  String receiver;
  String senderAddress;
  String receiverAddress;
  String coinImg;
  double amountTransfered;
  String coinTransfered;
  Transactions(
      {required this.sender,
      required this.receiver,
      required this.senderAddress,
      required this.receiverAddress,
      required this.amountTransfered,
      required this.coinImg,
      required this.coinTransfered});
}
