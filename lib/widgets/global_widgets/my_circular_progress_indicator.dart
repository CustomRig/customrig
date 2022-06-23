import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final bool darkColor;
  const MyCircularProgressIndicator({Key? key, this.darkColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      width: 10,
      child: CircularProgressIndicator(
        color: darkColor
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
