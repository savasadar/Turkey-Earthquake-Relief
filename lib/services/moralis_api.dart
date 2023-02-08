import 'dart:convert';

import 'package:admin/models/RecentDonaiton.dart';
import 'package:admin/models/chain.dart';
import 'package:admin/models/token.model.dart';
import 'package:admin/services/firebase_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MoralisAPI {
  static String apiKey = 'pBg33FdRMQ1T1Iig3QxYumap0NbScrs8l870lx6IEqrQEX90gR8QfxhnwjKVp746';
  static String baseURL = 'https://deep-index.moralis.io/api/v2';

  static Map<String, String> headers = {
    'X-API-Key': apiKey,
    'accept': 'application/json',
  };

  static Future getBalance(String address, Chain chain) async {
    var url = Uri.parse('$baseURL/$address/erc20?chain=${chain.shortName}');

    var response = await http.get(
      url,
      headers: headers,
    );

    double totalUSD = 0;

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      for (var tokenData in data) {
        int decimals = tokenData['decimals'] ?? 18;
        BigInt balance = BigInt.tryParse(tokenData['balance']) ?? BigInt.zero;
        String address = tokenData['token_address'];

     
        Token? token = await getToken(address, chain, {
          'decimals': decimals,
          'symbol': tokenData['symbol'],
          'name': tokenData['name'],
          'logo': tokenData['logo'],
        });

        if (token == null) {
          continue;
        }

        totalUSD += (balance / BigInt.from(10).pow(decimals)) * token.priceUSD;
      }

      BigInt nativeBalance = await getNativeBalance(address, chain.shortName);
      Token? token = await getToken(chain.priceAddress, chain, {});

      if (token == null) {
        return totalUSD;
      }

      totalUSD += (nativeBalance / BigInt.from(10).pow(18)) * token.priceUSD;

      return totalUSD;

    } else {
      return 0;
    }
  }

  static Future<Token?> getToken(String contractAddress, Chain chain, Map tokenData) async {
    List<String> blacklist = ['DIVIDEND_TRACKER', 'Dividend_Tracker', 'SquidGameToken_Dividend_Tracker', 'ETHBack_Dividend_Tracker', 'MITH', 'TRYC'];

    if (blacklist.contains(tokenData['symbol'])) {
      return null;
    }

    if (FirebaseManager.tokens != null) {
      if (FirebaseManager.tokens![chain.shortName] != null) {
        if (FirebaseManager.tokens![chain.shortName]![contractAddress] != null) {
          var data = FirebaseManager.tokens![chain.shortName]![contractAddress];

          return Token(
            priceUSD: data['usdPrice'] ?? 0,
            name: data['name'] ?? 'Ethereum',
            symbol: data['symbol'] ?? chain.symbol,
            decimals: data['decimals'] ?? 18,
            logo: data['logo'] ?? null,
          );
        }
      }
    }

    if (tokenData.isEmpty) {
      return null;
    }

    var url = Uri.parse('$baseURL/erc20/$contractAddress/price?chain=${chain.shortName}');

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      var d = {
        'symbol': tokenData['symbol'],
        'name': tokenData['name'],
        'decimals': tokenData['decimals'],
        'usdPrice': data['usdPrice'],
        'logo': tokenData['logo'],
      };

      FirebaseManager.saveTokenPrice(contractAddress, d, chain.shortName);
      return Token(
        priceUSD: data['usdPrice'] ?? 0,
        name: data['name'] ?? '',
        symbol: data['symbol'] ?? '',
        decimals: data['decimals'] ?? 18,
        logo: tokenData['logo'],
      );
    } else {
      return null;
    }
  }

  static Future<BigInt> getNativeBalance(String address, String chain) async {
    var url = Uri.parse('$baseURL/$address/balance?chain=$chain');

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return BigInt.tryParse(data['balance'].toString()) ?? BigInt.zero;
    } else {
      return BigInt.zero;
    }
  }

  static Future getRecentTransactions(String address, Chain chain) async {
    var url = Uri.parse('$baseURL/$address/verbose?chain=${chain.shortName}&limit=1');

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<RecentDonation> transactions = data['result'].map<RecentDonation>((e) {
        double amount = 0;
      }).toList();

      return data;
    } else {
      return [];
    }
  }

  static Future<List<RecentDonation>> getRecentERC20Transactions(String address, Chain chain) async {
    var url = Uri.parse('$baseURL/$address/erc20/transfers?chain=${chain.shortName}&limit=10');

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List result = data['result'];

      List<RecentDonation> transactions = [];

      for (var tokenTransfer in result) {
        Token? token = await getToken(tokenTransfer['address'], chain, {});

        if (token == null) {
          continue;
        }

        transactions.add(
          RecentDonation(
            date: DateTime.parse(tokenTransfer['block_timestamp']),
            amount: (BigInt.parse(tokenTransfer['value']) / BigInt.from(10).pow(token.decimals)).toDouble(),
            chain: chain,
            donor: tokenTransfer['from_address'],
            token: token,
            txHash: tokenTransfer['transaction_hash'],
          ),
        );
      }

      return transactions;
    } else {
      return <RecentDonation>[];
    }
  }
}
