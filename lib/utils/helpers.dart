import 'package:flutter/material.dart';

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
