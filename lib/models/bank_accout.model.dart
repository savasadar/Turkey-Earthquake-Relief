import 'package:flutter/material.dart';

class BankAccount {
  final String organizationName;
  final String bankName;
  final String iban;
  final String currency;
  final String? swiftCode;
  final String? proof;

  BankAccount({
    required this.organizationName,
    required this.bankName,
    required this.iban,
    required this.currency,
    this.swiftCode,
    this.proof,
  });

  Color get organizationColor {
    switch (organizationName) {
      case "AHBAP":
        return Color(0xFF81B222);
      case "AFAD":
        return Color(0xFF002B6C);
      case "KIZILAY":
        return Color(0xFFD30D17);
      default:
        return Colors.white;
    }
  }
}

List bankAccounts = [
  BankAccount(
    organizationName: "AHBAP",
    bankName: "İş Bankası",
    iban: "TR150006400000210212150277",
    currency: "EUR",
    swiftCode: "ISBKTRIS",
    proof: "",
  ),
  BankAccount(
    organizationName: "AHBAP",
    bankName: "İş Bankası",
    iban: "TR320006400000210212150262",
    currency: "USD",
    swiftCode: "ISBKTRIS",
    proof: "",
  ),
  BankAccount(
    organizationName: "AHBAP",
    bankName: "İş Bankası",
    iban: "TR120006400000110211380059",
    currency: "TL",
    swiftCode: "",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR730001001745555555555204",
    currency: "TL",
    swiftCode: "",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR460001001745555555555205",
    currency: "USD",
    swiftCode: "TCZBTR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR190001001745555555555206",
    currency: "EUR",
    swiftCode: "TCZBTR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR430001001745555555555356",
    currency: "GPB",
    swiftCode: "TCZBTR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANK INTERNATIONAL",
    iban: "DE50512207002000452454",
    currency: "EUR",
    swiftCode: "TCZBDEFF",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "TÜRKİYE VAKIFLAR BANKASI",
    iban: "TR62 0001 5001 5800 7299 3175 99",
    currency: "TL",
    swiftCode: "",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "TÜRKİYE VAKIFLAR BANKASI",
    iban: "TR43 0001 5001 5804 8013 0940 88",
    currency: "USD",
    swiftCode: "TVBATR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "TÜRKİYE VAKIFLAR BANKASI",
    iban: "TR32 0001 5001 5804 8013 0940 92",
    currency: "EUR",
    swiftCode: "TVBATR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "TÜRKİYE HALK BANKASI A.Ş",
    iban: "TR88 0001 2009 4080 0005 0002 28",
    currency: "TL",
    swiftCode: "",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "TÜRKİYE HALK BANKASI A.Ş",
    iban: "TR75 0001 2009 4080 0058 0002 92",
    currency: "USD",
    swiftCode: "TRHBTR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "TÜRKİYE HALK BANKASI A.Ş",
    iban: "TR48 0001 2009 4080 0058 0002 93",
    currency: "EUR",
    swiftCode: "TRHBTR2A",
    proof: "https://www.afad.gov.tr/depremkampanyasi2",
  ),

  BankAccount(
    organizationName: "KIZILAY",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR480001002110000028685254",
    currency: "TL",
    swiftCode: "",
    proof: "https://www.kizilay.org.tr/Bagis/BagisYap/404/pazarcik-depremi-bagisi",
  ),
  BankAccount(
    organizationName: "KIZILAY",
    bankName: "ZİRAAT BANKASI FRANKFURT",
    iban: "DE26512207001080000001",
    currency: "EUR",
    swiftCode: "TCZBDEFF",
    proof: "https://www.kizilay.org.tr/Bagis/BagisYap/404/pazarcik-depremi-bagisi",
  ),
];
