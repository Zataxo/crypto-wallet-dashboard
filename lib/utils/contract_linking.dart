import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  static const contractName = "CryptoWallet";
  static const ip = "10.177.1.238";
  static const port = "7545";

  final String rpcUrl = "http://$ip:$port";
  final String wsUrl = "ws://$ip:$port";
  final String _privateKey =
      "0x6cf196574d7876f5fa56ab9ea67ce71d4d33c17e7118f5e94b075d1967694635";

  late Web3Client client;
  late Credentials credintails;
  late DeployedContract contract;
  // List of function to be called from our smart contract
  late ContractFunction totalUsers;
  late ContractFunction loginFunction;
  late ContractFunction usersMap;
  late ContractFunction totalTransactions;
  late ContractFunction transactionsMap;
  late ContractFunction depositCoin;
  late ContractFunction transferFund;
  late ContractFunction getUserModel;

  intialize() async {
    // intialize the client --> requires http package
    client = Web3Client(rpcUrl, Client(),
        socketConnector: () =>
            IOWebSocketChannel.connect(wsUrl).cast<String>());
    final abiStringFile =
        await rootBundle.loadString("truffle-artifacts/$contractName.json");
    final jsonAbi = jsonDecode(abiStringFile);
    final abi = jsonEncode(jsonAbi["abi"]);
    final contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    credintails = EthPrivateKey.fromHex(_privateKey);
    contract = DeployedContract(
        ContractAbi.fromJson(abi, contractName), contractAddress);

    // Declaring Functions =>
    totalUsers = contract.function("totalUsers");
    loginFunction = contract.function("login");
    usersMap = contract.function("usersMap");
    totalTransactions = contract.function("totalTransactions");
    transactionsMap = contract.function("transactionsMap");
    depositCoin = contract.function("deposit");
    transferFund = contract.function("transferFund");
    getUserModel = contract.function("getUserModel");
    notifyListeners();
  }

  // Future<void> getAnyData(
  //     ContractFunction _functionCalling, List<dynamic> _params) async {
  //   try {
  //     final response = await client.call(
  //         contract: contract, function: _functionCalling, params: _params);
  //     log(response.toString());
  //     // setReponse(response);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }

  // void setReponse(List<dynamic> response) {
  //   res = response;
  //   notifyListeners();
  // }
}
