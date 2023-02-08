import 'package:help2turkey/models/account_info.model.dart';
import 'package:help2turkey/models/chain.enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../utils/constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.account,
  }) : super(key: key);

  final AccountInfo account;

  String hideAddress(String address) {
    return address.substring(0, 6) + '...' + address.substring(address.length - 4, address.length);
  }

  Color? getColor() {
    if (account.chain.shortName == 'tron') {
      return Colors.white;
    }

    if (account.chain.shortName == 'polkadot') {
      return account.chain.color;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.6),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: account.chain.color.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    account.chain.icon,
                    color: getColor(),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    ClipboardData data = ClipboardData(text: account.address);
                    await Clipboard.setData(data);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${account.chain.name} address to clipboard'),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
            Text(
              account.chain.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hideAddress(account.address!),
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          account.organization,
                          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white70),
                        ),
                        // Text(
                        //   info.totalStorage!,
                        //   style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
                        // ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Container(
                            width: 400,
                            height: 400,
                            child: QrImage(data: account.address!),
                          ),
                        );
                      },
                    );
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      child: QrImage(
                        size: 40,
                        data: account.address!,
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
