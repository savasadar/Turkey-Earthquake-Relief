import 'dart:math';

import 'package:admin/models/account_info.model.dart';
import 'package:admin/components/responsive.dart';
import 'package:admin/services/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'account_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Validated Accounts",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            //     ),
            //   ),
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            //   label: Text("Add New"),
            // ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
  }) : super(key: key);

  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = context.watch<DonationProvider>();
    List<AccountInfo> accounts = donationProvider.accounts;

    return LayoutBuilder(builder: (context, con) {
      int crossAxisCount = this.crossAxisCount;
      double childAspectRatio = 1;

      crossAxisCount = max((con.maxWidth ~/ 190).toInt(), 1);

      if (crossAxisCount == 1) {
        childAspectRatio = 2;
      }

      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: accounts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => FileInfoCard(account: accounts[index]),
      );
    });
  }
}
