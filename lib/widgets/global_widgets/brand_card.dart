import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key? key,
    required this.brandsLength,
    required this.brand,
    required this.isSelected,
    required this.onBrandChanged,
  }) : super(key: key);

  final int brandsLength;
  final String brand;
  final bool isSelected;
  final void Function(String) onBrandChanged;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double calculatedSizeForCard;

    // this calculates the size of the card based on number of cards
    switch (brandsLength) {
      case 1:
        calculatedSizeForCard = 0.3;
        break;
      case 2:
        calculatedSizeForCard = 0.45;
        break;
      case 3:
        calculatedSizeForCard = 0.300;
        break;
      case 4:
        calculatedSizeForCard = 0.3;
        break;
      default:
        calculatedSizeForCard = 0.0;
    }

    // if cards are more than 4, than set this below size and wrap to bottom
    if (brandsLength > 4) calculatedSizeForCard = 0.3;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () => onBrandChanged(brand),
        child: Material(
          elevation: 2.3,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(isSelected ? 3.0 : 6.0),
            child: Center(
              child: Text(
                brand,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      width: 4,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            height: screenSize.width * 0.18,
            width: screenSize.width * calculatedSizeForCard,
          ),
        ),
      ),
    );
  }
}
