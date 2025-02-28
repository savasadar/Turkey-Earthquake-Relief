import 'package:help2turkey/models/chain.enum.dart';
import 'package:help2turkey/models/token.model.dart';

class Donation {
  final String? donor;
  final Chain chain;
  final DateTime date;
  final double amount;
  Token token;
  String txHash = '';

  Donation({
    this.donor,
    required this.date,
    required this.amount,
    required this.chain,
    required this.token,
    this.txHash = '',
  });
}
