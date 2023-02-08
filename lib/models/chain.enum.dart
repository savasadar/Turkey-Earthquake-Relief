import 'package:help2turkey/utils/constants.dart';
import 'package:flutter/material.dart';

enum Chain {
  ethereum,
  avalanche,
  binance,
  bitcoin,
  tron,
  polkadot,
}

extension ChainData on Chain {
  String get name {
    switch (this) {
      case Chain.ethereum:
        return 'Ethereum';
      case Chain.avalanche:
        return 'Avalanche';
      case Chain.binance:
        return 'Binance Smart Chain';
      case Chain.bitcoin:
        return 'Bitcoin';
      case Chain.tron:
        return 'Tron';
      case Chain.polkadot:
        return 'Polkadot';
    }
  }

  String get icon {
    switch (this) {
      case Chain.ethereum:
        return 'assets/icons/chains/ethereum.svg';
      case Chain.avalanche:
        return 'assets/icons/chains/avalanche.svg';
      case Chain.binance:
        return 'assets/icons/chains/binance.svg';
      case Chain.bitcoin:
        return 'assets/icons/chains/bitcoin.svg';
      case Chain.tron:
        return 'assets/icons/chains/tron.svg';
      case Chain.polkadot:
        return 'assets/icons/chains/polkadot.svg';
    }
  }

  String get symbol {
    switch (this) {
      case Chain.ethereum:
        return 'ETH';
      case Chain.avalanche:
        return 'AVAX';
      case Chain.binance:
        return 'BNB';
      case Chain.bitcoin:
        return 'BTC';
      case Chain.tron:
        return 'TRX';
      case Chain.polkadot:
        return 'DOT';
    }
  }

  Color get color {
    switch (this) {
      case Chain.ethereum:
        return primaryColor;
      case Chain.avalanche:
        return Color(0xFFE84142);
      case Chain.binance:
        return Color(0xFFFFA113);
      case Chain.bitcoin:
        return Color(0xFFE8A42A);
      case Chain.tron:
        return Color(0xFF1E1E1E);
      case Chain.polkadot:
        return Color(0xFFE6007A);
    }
  }

  String get shortName {
    switch (this) {
      case Chain.ethereum:
        return 'eth';
      case Chain.avalanche:
        return 'avalanche';
      case Chain.binance:
        return 'bsc';
      case Chain.bitcoin:
        return 'btc';
      case Chain.tron:
        return 'tron';
      case Chain.polkadot:
        return 'polkadot';
    }
  }

  String get priceAddress {
    switch (this) {
      case Chain.ethereum:
        return '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2';
      case Chain.avalanche:
        return '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7';
      case Chain.binance:
        return '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c';
      case Chain.bitcoin:
        return '0x2260fac5e5542a773aa44fbcfedf7c193bc2c599';
      case Chain.tron:
        return '0x85eac5ac2f758618dfa09bdbe0cf174e7d574d5b';
      case Chain.polkadot:
        return '0x7083609fce4d1d8dc0c979aab8c869ea2c873402';
    }
  }

  String get explorer {
    switch (this) {
      case Chain.ethereum:
        return 'https://etherscan.io';
      case Chain.avalanche:
        return 'https://snowtrace.io';
      case Chain.binance:
        return 'https://bscscan.com';
      case Chain.bitcoin:
        return 'https://blockstream.info';
      case Chain.tron:
        return 'https://tronscan.org';
      case Chain.polkadot:
        return 'https://polkascan.io';
    }
  }
}
