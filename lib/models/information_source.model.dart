import 'package:flutter/material.dart';

class InformationSource {
  String type;
  String link;
  String organization;
  Color color;

  InformationSource({
    required this.type,
    required this.link,
    required this.organization,
    required this.color,
  });
}

List<InformationSource> sources = [
  InformationSource(
      type: 'Crypto',
      link: 'https://www.kizilay.org.tr/bagis-yontemleri/kripto-para-birimleri-ile-bagis',
      organization: 'Kızılay',
      color: Color(0xFFFF2400)),
  InformationSource(
    type: 'IBAN',
    link: 'https://www.afad.gov.tr/deprem-bagislari',
    organization: 'AFAD',
    color: Color(0xFF002B6C),
  ),
  InformationSource(
    type: 'Crypto',
    link: 'https://twitter.com/haluklevent/status/1622913175409623041',
    organization: 'Ahbap',
    color: Color(0xFF81B222),
  ),
];
