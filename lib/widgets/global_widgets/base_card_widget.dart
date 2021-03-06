import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final VoidCallback onTap;
  const BaseCard({
    Key? key,
    required this.child,
    required this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(3.0),
      child: Material(
        elevation: 2.3,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          splashColor: Theme.of(context).colorScheme.primaryContainer,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
