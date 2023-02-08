import 'package:admin/models/account_info.model.dart';
import 'package:admin/models/chain.enum.dart';
import 'package:admin/services/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'chart.dart';
import 'chain_fund_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = context.watch<DonationProvider>();

    List<AccountInfo> accounts = [];

    for (AccountInfo accountInfo in donationProvider.accounts) {
      if (!accountInfo.fetchData) {
        continue;
      }

      if (accounts.where((element) => element.chain == accountInfo.chain).isEmpty) {
        accounts.add(accountInfo);
      } else {
        AccountInfo account = accounts.firstWhere((element) => element.chain == accountInfo.chain);
        account.totalAmountUSD += accountInfo.totalAmountUSD;
      }
    }

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Raised",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          ...accounts
              .map((e) => StorageInfoCard(
                    svgSrc: e.chain.icon,
                    title: e.chain.name,
                    totalAmountUSD: e.totalAmountUSD,
                    numOfFiles: e.totalDonations!,
                  ))
              .toList(),
        ],
      ),
    );
  }
}
