import 'package:customrig/model/base_item.dart';
import 'package:customrig/pages/product_page.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/base_card_widget.dart';
import 'package:flutter/material.dart';

class MainProductCard extends StatelessWidget {
  final BaseItem item;
  const MainProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;

    return BaseCard(
      width: screenDimension.width * 0.4,
      onTap: () => goToPage(context, ProductPage(item: item)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              height: screenDimension.height * .2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          spacer(height: 6),
          SizedBox(
            width: screenDimension.height * .2,
            child: Text(
              item.title ?? '',
              style: MyTextStyles.productSubtitle
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          spacer(height: 4),
          Text(
            '₹ ' + formatCurrency(item.price ?? 0),
            style: MyTextStyles.productTitle
                .copyWith(color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }
}
