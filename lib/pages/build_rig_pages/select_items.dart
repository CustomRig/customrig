import 'package:customrig/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../utils/helpers.dart';

class SelectItems extends StatelessWidget {
  final String itemName;
  final List items;
  const SelectItems({
    Key? key,
    required this.itemName,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text(
        'Select ${itemName.snakeCaseToTitleCase()}',
        style: MyTextStyles.heading,
      ),
    ]);
  }
}
