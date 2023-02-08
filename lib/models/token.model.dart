class Token {
  int decimals;
  String symbol;
  String? name;
  double priceUSD;
  String? logo;

  Token({
    required this.priceUSD,
    this.name,
    required this.symbol,
    required this.decimals,
    this.logo,
  });
}
