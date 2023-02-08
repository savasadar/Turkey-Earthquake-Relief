import 'package:admin/constants.dart';
import 'package:admin/models/chain.dart';
import 'package:flutter/material.dart';

class AccountInfo {
  final String? address;
  int? totalDonations, percentage;

  final Chain chain;
  double totalAmount;
  double totalAmountUSD;

  String organization;

  bool fetchData;

  AccountInfo({
    required this.chain,
    this.totalDonations,
    this.percentage,
    this.address,
    required this.totalAmount,
    required this.totalAmountUSD,
    required this.organization,
    this.fetchData = true,
  });
}
