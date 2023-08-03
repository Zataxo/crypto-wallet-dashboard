// Helpfull Funcs
String getCoinFullName(String _coinsShortCut) {
  if (_coinsShortCut == "btc") {
    return "Bitcoin";
  } else if (_coinsShortCut == "eth") {
    return "Ethereum";
  } else if (_coinsShortCut == "ltc") {
    return "Litcoin";
  } else if (_coinsShortCut == "sol") {
    return "Solana";
  } else {
    return "Binance";
  }
}

String getCoinLogo(String _coinsShortCut) {
  if (_coinsShortCut == "btc") {
    return "assets/icons/btc_dashboard.svg";
  } else if (_coinsShortCut == "eth") {
    return "assets/icons/eth_dashboard.svg";
  } else if (_coinsShortCut == "ltc") {
    return "assets/icons/ltc_dashboard.svg";
  } else if (_coinsShortCut == "sol") {
    return "assets/icons/sol_dashboard.svg";
  } else {
    return ("assets/icons/binance_dashboard.svg");
  }
}

//
