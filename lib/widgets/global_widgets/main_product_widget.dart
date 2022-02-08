import 'package:customrig/utils/dummy_data.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/base_card_widget.dart';
import 'package:flutter/material.dart';

class MainProductCard extends StatelessWidget {
  final String title;
  // final String description;
  final int price;
  final String imageUrl;
  const MainProductCard({
    Key? key,
    required this.title,
    // required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenDimension.height * .2,
            height: screenDimension.height * .2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          spacer(height: 4),
          SizedBox(
            width: screenDimension.height * .2,
            child: Text(
              title,
              style: MyTextStyles.productSubtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          spacer(height: 4),
          Text(
            '₹' + price.toString(),
            style: MyTextStyles.productTitle,
          )
        ],
      ),
    );
  }
}
