import 'package:customrig/utils/colors.dart';
import 'package:customrig/utils/dummy_data.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/base_card_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SmallProductCard extends StatelessWidget {
  const SmallProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;

    return BaseCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenDimension.width * 0.2,
            width: screenDimension.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: const DecorationImage(
                image: NetworkImage(kDummyProductImage),
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
                  kDummyTitle,
                  style: MyTextStyles.productTitle.copyWith(color: Colors.blue),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  kDummyDescription,
                  style: MyTextStyles.productSubtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  '₹' + kDummyPrice,
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
              onTap: () {},
              child: const Icon(EvaIcons.closeCircleOutline),
            ),
          )
        ],
      ),
    );
  }
}
