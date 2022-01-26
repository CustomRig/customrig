import 'package:customrig/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../utils/helpers.dart';

class SelectItems extends StatelessWidget {
  final String itemName;
  final List items;
  const SelectItems({
    Key? key,
    required this.itemName,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: Text(
            'Select ${itemName.snakeCaseToTitleCase()}',
            style: MyTextStyles.heading,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Wrap(
            children: [
              _buildBrandCard(),
              _buildBrandCard(),
              _buildBrandCard(),
              _buildBrandCard(),
              _buildBrandCard(),
              _buildBrandCard(),
              _buildBrandCard(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBrandCard() {
    return BrandCard(
      itemsLength: 5,
    );
  }
}

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key? key,
    required this.itemsLength,
  }) : super(key: key);

  final int itemsLength;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double calculatedSizeForCard;

    // this calculates the size of the card based on number of cards
    switch (itemsLength) {
      case 1:
        calculatedSizeForCard = 0.3;
        break;
      case 2:
        calculatedSizeForCard = 0.46;
        break;
      case 3:
        calculatedSizeForCard = 0.302;
        break;
      case 4:
        calculatedSizeForCard = 0.223;
        break;
      default:
        calculatedSizeForCard = 0.0;
    }

    // if cards are more than 4, than set this below size and wrap to bottom
    if (itemsLength > 4) calculatedSizeForCard = 0.223;

    return Padding(
      padding: const EdgeInsets.all(3),
      child: Material(
        elevation: 2.3,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/brands/asus.png'),
              fit: BoxFit.fill,
            ),
          ),
          height: screenSize.width * calculatedSizeForCard,
          width: screenSize.width * calculatedSizeForCard,
        ),
      ),
    );
  }
}
