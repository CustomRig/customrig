import 'package:flutter/material.dart';

class MyHorizontalList extends StatelessWidget {
  final List<Widget> items;
  const MyHorizontalList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }
}
