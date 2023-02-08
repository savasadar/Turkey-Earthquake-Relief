import 'package:admin/models/chain.dart';
import 'package:admin/models/token.model.dart';

class RecentDonation {
  final String? donor;
  final Chain chain;
  final DateTime date;
  final double amount;
  Token token;
  String txHash = '';

  RecentDonation({
    this.donor,
    required this.date,
    required this.amount,
    required this.chain,
    required this.token,
    this.txHash = '',
  });
}
