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
