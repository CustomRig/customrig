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
          color: secondary ? Colors.green : Colors.blue,
        ),
        color: secondary
            ? Colors.green.withOpacity(.1)
            : Colors.blue.withOpacity(.1),
      ),
      width: screenSize.width * .2,
      height: 30,
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: secondary ? Colors.green : Colors.blue,
        ),
      ),
    );
  }
}
