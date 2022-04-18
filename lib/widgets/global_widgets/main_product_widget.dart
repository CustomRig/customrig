import 'package:customrig/model/base_item.dart';
import 'package:customrig/pages/product_page.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/base_card_widget.dart';
import 'package:flutter/material.dart';

class MainProductCard extends StatelessWidget {
  // final String title;
  // // final String description;
  // final int price;
  // final String imageUrl;
  final BaseItem item;
  const MainProductCard({
    Key? key,
    required this.item,
    // required this.title,
    // // required this.description,
    // required this.price,
    // required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;

    return BaseCard(
      onTap: () => goToPage(context, ProductPage(item: item)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenDimension.height * .2,
            height: screenDimension.height * .2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          spacer(height: 4),
          SizedBox(
            width: screenDimension.height * .2,
            child: Text(
              item.title ?? '',
              style: MyTextStyles.productSubtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          spacer(height: 4),
          Text(
            '₹' + item.price.toString(),
            style: MyTextStyles.productTitle,
          )
        ],
      ),
    );
  }
}
