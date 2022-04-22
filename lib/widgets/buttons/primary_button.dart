import 'package:customrig/utils/helpers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget suffix;
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.4,
      height: 42.0,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text.toUpperCase()),
            spacer(width: 8.0),
            suffix,
          ],
        ),
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            // fontWeight: FontWeight.bold,
          ),
          primary: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
