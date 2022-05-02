import 'package:customrig/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../../model/item.dart';

class BuildRigItemCard extends StatelessWidget {
  final Item item;
  final bool isSelected;

  final void Function(Item) onItemChanged;
  const BuildRigItemCard({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onItemChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 2.4,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => onItemChanged(item),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: isSelected
                  ? Border.all(
                      width: 6,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item.title!,
                  maxLines: 2,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                spacer(height: 4),
                Text(
                  item.description!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  '₹ ' + formatCurrency(item.price!),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
