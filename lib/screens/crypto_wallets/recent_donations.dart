import 'package:admin/models/donation.model.dart';
import 'package:admin/models/chain.enum.dart';
import 'package:admin/services/providers/relief_provider.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

class RecentDonations extends StatelessWidget {
  const RecentDonations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReliefProvider reliefProvider = context.watch<ReliefProvider>();

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Donations",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 530,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 750,
              columns: [
                DataColumn(
                  label: Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Text("Donor"),
                  ),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
              ],
              rows: reliefProvider.recentDonations == null
                  ? []
                  : reliefProvider.recentDonations!
                      .map(
                        (e) => recentFileDataRow(e),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(Donation fileInfo) {
  String hideAddress(String address) {
    return address.substring(0, 6) + '...' + address.substring(address.length - 4, address.length);
  }

  String parseAmount() {
    if (fileInfo.amount < 1) {
      return fileInfo.amount.toStringAsFixed(4);
    } else if (fileInfo.amount < 5) {
      return fileInfo.amount.toStringAsFixed(2);
    } else {
      return fileInfo.amount.toStringAsFixed(0);
    }
  }

  String amount = parseAmount();

  return DataRow(
    key: UniqueKey(),
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding * 0.6),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                fileInfo.chain.icon,

                // color: info.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(hideAddress(fileInfo.donor!)),
            ),
            IconButton(
                onPressed: () {
                  String url = fileInfo.chain.explorer + '/tx/' + fileInfo.txHash;
                  launchUrl(Uri.parse(url));
                },
                icon: Icon(Icons.link))
          ],
        ),
      ),
      DataCell(
        Text(
          amount + ' ' + fileInfo.token.symbol,
        ),
      ),
      DataCell(Text(DateFormat('yyyy/MM/dd - HH:mm UTC').format(fileInfo.date))),
    ],
  );
}
