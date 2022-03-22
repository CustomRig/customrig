import 'package:flutter/material.dart';

class MyBadge extends StatelessWidget {
  final String text;
  final bool secondary;
  const MyBadge({
    Key? key,
    required this.text,
    this.secondary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.2,
          color: secondary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.tertiaryContainer,
        ),
        color: secondary
            ? Theme.of(context).colorScheme.primary.withOpacity(.5)
            : Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.5),
      ),
      width: screenSize.width * .2,
      height: 30,
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: secondary
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onTertiaryContainer,
        ),
      ),
    );
  }
}
