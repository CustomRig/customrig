import 'package:customrig/model/base_item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../utils/helpers.dart';

class ItemDetailsDialog extends StatelessWidget {
  final BaseItem item;
  const ItemDetailsDialog(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.height * 0.4,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            spacer(height: 6),
            Text(
              item.title!,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            spacer(height: 6),
            Text(
              '₹ ' + formatCurrency(item.price!),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            spacer(height: 6),
            Text(
              item.description!,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            launchURL(item.purchaseUrl ?? '');
          },
          icon: const Icon(EvaIcons.shoppingBagOutline),
          label: const Text('VIEW'),
        ),
      ],
    );
  }
}
