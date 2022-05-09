import 'package:customrig/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../../model/item.dart';

class BuildRigItemCard extends StatelessWidget {
  final Item item;
  final bool isSelected;

  final void Function(Item) onItemChanged;
  final void Function(Item) showItemDetails;

  const BuildRigItemCard({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onItemChanged,
    required this.showItemDetails,
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
          onLongPress: () => showItemDetails(item),
          child: Container(
            padding: EdgeInsets.all(isSelected ? 6.0 : 12.0),
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
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                spacer(height: 4),
                Text(
                  item.description!,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  item.price! == 0
                      ? 'FREE'
                      : '₹ ' + formatCurrency(item.price!),
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
