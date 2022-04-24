import 'package:flutter/material.dart';

class MyBadge extends StatelessWidget {
  final String text;
  const MyBadge({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
          width: 1.2,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      width: screenSize.width * .25,
      height: 30,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
