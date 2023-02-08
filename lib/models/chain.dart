import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

enum Chain {
  ethereum,
  avalanche,
  binance,
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
    }
  }
}
