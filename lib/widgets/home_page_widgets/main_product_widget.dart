import 'package:customrig/utils/dummy_data.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/base_card_widget.dart';
import 'package:flutter/material.dart';

class MainProductCard extends StatelessWidget {
  const MainProductCard({Key? key}) : super(key: key);

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
              image: const DecorationImage(
                image: NetworkImage(kDummyProductImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          spacer(height: 4),
          SizedBox(
            width: screenDimension.height * .2,
            child: const Text(
              kDummyDescription,
              style: MyTextStyles.productSubtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          spacer(height: 4),
          const Text(
            '₹' + kDummyPrice,
            style: MyTextStyles.productTitle,
          )
        ],
      ),
    );
  }
}
