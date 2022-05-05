import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

spacer({double? height, double? width}) {
  return SizedBox(height: height ?? 0, width: width ?? 0);
}

void goToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void showMySnackBar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void replacePage(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void pushReplacement(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
    (_) => false,
  );
}

extension StringExtension on String {
  String snakeCaseToTitleCase() {
    final words = split('_');
    List<String> finalWords = [];
    for (var word in words) {
      finalWords.add(word[0].toUpperCase() + word.substring(1).toLowerCase());
    }
    return finalWords.join(' ');
  }
}

String formatCurrency(int price) {
  final format = NumberFormat(
    '##,##,###',
  );
  return format.format(price);
}

void launchURL(String url) async {
  try {
    launchUrl(Uri.parse(url));
  } on Exception catch (e) {}
}

String? getBrandImage(String brand) {
  String? _brand;
  switch (brand) {
    case 'ACER':
      _brand = 'ACER.PNG';
      break;

    case 'AMAZONBASICS':
      _brand = 'AMAZONBASICS.PNG';
      break;

    case 'AMD':
      _brand = 'AMD.PNG';
      break;

    case 'ANT ESPORTS':
      _brand = 'ANT_ESPORTS.PNG';
      break;

    case 'ANTEC':
      _brand = 'ANTEC.PNG';
      break;

    case 'ASUS':
      _brand = 'ASUS.PNG';
      break;
    case 'BENQ':
      _brand = 'BENQ.PNG';
      break;

    case 'CIRCLE':
      _brand = 'CIRCLE.PNG';
      break;
    case 'COOLER MASTER':
      _brand = 'COOLER_MASTER.PNG';
      break;
    case 'ASUS':
      _brand = 'asus.PNG';
      break;
    case 'CORSAIR':
      _brand = 'CORSAIR.PNG';
      break;
    case 'CRUCIAL':
      _brand = 'CRUCIAL.PNG';
      break;
    case 'DEEPCOOL':
      _brand = 'DEEPCOOL.PNG';
      break;

    case 'GIGABYTE':
      _brand = 'GIGABYTE.PNG';
      break;

    case 'HP':
      _brand = 'HP.PNG';
      break;

    case 'IBALL':
      _brand = 'IBALL.PNG';
      break;

    case 'INNO3D':
      _brand = 'INNO3D.PNG';
      break;

    case 'INTEL':
      _brand = 'INTEL.PNG';
      break;

    case 'LG':
      _brand = 'LG.PNG';
      break;

    case 'LINUX':
      _brand = 'LINUX.PNG';
      break;

    case 'LOGITECH':
      _brand = 'LOGITECH.PNG';
      break;

    case 'MICROSOFT':
      _brand = 'MICROSOFT.PNG';
      break;

    case 'MSI':
      _brand = 'MSI.PNG';
      break;

    case 'NZXT':
      _brand = 'NZXT.PNG';
      break;

    case 'RAZER':
      _brand = 'RAZER.PNG';
      break;

    case 'REDGEAR':
      _brand = 'REDGEAR.PNG';
      break;

    case 'SAMSUNG':
      _brand = 'SAMSUNG.PNG';
      break;

    case 'SAPPHIRE':
      _brand = 'SAPPHIRE.PNG';
      break;

    case 'SILVERSTONE':
      _brand = 'SILVERSTONE.PNG';
      break;

    case 'TP-LINK':
      _brand = 'TP_LINK.PNG';
      break;

    case 'WD':
      _brand = 'WD.PNG';
      break;

    case 'XINRUB':
      _brand = 'XINRUB.PNG';
      break;

    case 'XPG':
      _brand = 'XPG.PNG';
      break;

    case 'ZEBRONICS':
      _brand = 'ZEBRONICS.PNG';
      break;

    case 'ZOTAC':
      _brand = 'ZOTAC.PNG';
      break;

    default:
      _brand = null;
      break;
  }
  print(_brand);
  return _brand;
}
