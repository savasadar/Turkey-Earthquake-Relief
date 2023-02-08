import 'package:admin/models/chain.enum.dart';
import 'package:admin/services/providers/donation_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<PieChartSectionData> paiChartSelectionDatas = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = context.watch<DonationProvider>();
    paiChartSelectionDatas = donationProvider.accounts.map((e) {
      return PieChartSectionData(
        color: e.chain.color,
        value: e.totalAmountUSD,
        showTitle: false,
        radius: 30,
      );
    }).toList();

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  NumberFormat.compactSimpleCurrency(name: 'USD', decimalDigits: 2).format(donationProvider.totalRaised),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
