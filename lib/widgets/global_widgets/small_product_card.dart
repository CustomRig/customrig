import 'package:customrig/model/base_item.dart';
import 'package:customrig/pages/product_page.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/base_card_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SmallProductCard extends StatelessWidget {
  final BaseItem item;
  final Function() onRemovePressed;
  const SmallProductCard({
    Key? key,
    required this.item,
    required this.onRemovePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;

    return BaseCard(
      onTap: () {
        goToPage(context, ProductPage(item: item));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenDimension.width * 0.2,
            width: screenDimension.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          spacer(width: 8.0),
          SizedBox(
            width: screenDimension.width * 0.55,
            height: screenDimension.width * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title ?? '',
                  style: MyTextStyles.productTitle.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.description ?? '',
                  style: MyTextStyles.productSubtitle
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '₹ ' + formatCurrency(item.price!),
                  style: MyTextStyles.productTitle,
                )
              ],
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Remove from favorites',
            child: InkWell(
              borderRadius: BorderRadius.circular(50.0),
              onTap: onRemovePressed,
              child: const Icon(EvaIcons.closeCircleOutline),
            ),
          )
        ],
      ),
    );
  }
}
