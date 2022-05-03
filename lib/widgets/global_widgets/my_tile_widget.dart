import 'package:customrig/utils/helpers.dart';
import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final bool isSelected;
  const MyTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        splashColor: theme.primaryContainer,
        onTap: onClick,
        child: Container(
          // margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            color: isSelected ? theme.primaryContainer : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? theme.onPrimaryContainer : theme.onSurface,
              ),
              spacer(width: 24),
              Text(
                title,
                style: TextStyle(
                  color:
                      isSelected ? theme.onPrimaryContainer : theme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
