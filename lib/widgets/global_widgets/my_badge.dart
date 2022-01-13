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
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: secondary ? Colors.green : Colors.blue,
        ),
      ),
      backgroundColor: secondary
          ? Colors.green.withOpacity(.1)
          : Colors.blue.withOpacity(.1),
      label: Text(
        '324100',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: secondary ? Colors.green : Colors.blue,
        ),
      ),
    );
  }
}
