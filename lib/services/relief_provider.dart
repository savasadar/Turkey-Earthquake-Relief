import 'package:admin/models/AccounInfo.dart';
import 'package:admin/models/RecentDonaiton.dart';
import 'package:admin/models/chain.dart';
import 'package:admin/services/firebase_manager.dart';
import 'package:admin/services/moralis_api.dart';
import 'package:flutter/material.dart';

class ReliefProvider with ChangeNotifier {
  ReliefProvider() {
    setTotalRaised();

    FirebaseManager.getTokenPrices().then((value) {
      getBalances();
    });
  }

  void getBalances() async {
    for (var account in accounts) {

      if (!account.fetchData) {
        continue;
      }

      account.totalAmountUSD = await MoralisAPI.getBalance(
        account.address!,
        account.chain,
      );

      MoralisAPI.getRecentERC20Transactions(account.address!, account.chain).then((value) {
        if (recentDonations == null) {
          recentDonations = value;
        } else {
          recentDonations!.addAll(value);
        }

        recentDonations!.sort((a, b) => b.date.compareTo(a.date));
        notifyListeners();
      });

      setTotalRaised();

      notifyListeners();
    }
  }

  List<RecentDonation>? recentDonations;

  List<AccountInfo> accounts = [
    AccountInfo(
      chain: Chain.ethereum,
      totalDonations: 1328,
      address: '0xe1935271D1993434A1a59fE08f24891Dc5F398Cd',
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Ahbap Derneği',
    ),
    AccountInfo(
      chain: Chain.binance,
      totalDonations: 1328,
      address: '0xB67705398fEd380a1CE02e77095fed64f8aCe463',
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Ahbap Derneği',
    ),
    AccountInfo(
      chain: Chain.avalanche,
      totalDonations: 1328,
      address: '0x868D27c361682462536DfE361f2e20B3A6f4dDD8',
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Ahbap Derneği',
    ),
    AccountInfo(
      chain: Chain.ethereum,
      totalDonations: 1328,
      address: '0x1fc82b7a62c0414163A332693Ec66EC91f4cd1dE'.toLowerCase(),
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Türk Kızılayı',
    ),
    AccountInfo(
      chain: Chain.avalanche,
      totalDonations: 1328,
      address: '0x1fc82b7a62c0414163A332693Ec66EC91f4cd1dE',
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Türk Kızılayı',
    ),
    AccountInfo(
      chain: Chain.bitcoin,
      totalDonations: 1328,
      address: 'bc1qe5vk78kmzq3v9xry3c9w7u09g0q9fvhsvuvsq5t6lvzfzatsdygs2whz3u',
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Türk Kızılayı',
      fetchData: false,
    ),
    AccountInfo(
      chain: Chain.tron,
      totalDonations: 1328,
      address: 'TWyAHQNttueddv5Hp9B1dAnBVrDNqBjrCo',
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Türk Kızılayı',
      fetchData: false,
    ),
    AccountInfo(
      chain: Chain.polkadot,
      totalDonations: 1328,
      address: '14FzHs6ESUbBdynBXMd26VSF9yZV6SGX1nWfffBh9MWAfL2K',
      totalAmount: 0,
      totalAmountUSD: 0,
      organization: 'Türk Kızılayı',
      fetchData: false,
    ),
  ];

  double totalRaised = 0;

  void setTotalRaised() {
    totalRaised = accounts.fold(0, (previousValue, element) => previousValue + element.totalAmountUSD);
    notifyListeners();
  }
}
