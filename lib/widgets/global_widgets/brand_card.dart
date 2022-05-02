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
        calculatedSizeForCard = 0.218;
        break;
      default:
        calculatedSizeForCard = 0.0;
    }

    // if cards are more than 4, than set this below size and wrap to bottom
    if (brandsLength > 4) calculatedSizeForCard = 0.223;

    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () => onBrandChanged(brand),
        child: Material(
          elevation: 2.3,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            child: !_isBrandImagePresent(brand)
                ? Center(
                    child: Text(
                    brand,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ))
                : null,
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      width: 6,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
              image: _isBrandImagePresent(brand)
                  ? DecorationImage(
                      image: AssetImage(
                          'assets/images/brands/' + _getBrandImage(brand)!),
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            height: screenSize.width * calculatedSizeForCard,
            width: screenSize.width * calculatedSizeForCard,
          ),
        ),
      ),
    );
  }

  bool _isBrandImagePresent(brand) => _getBrandImage(brand) != null;

  String? _getBrandImage(String brand) {
    String? _brand;
    switch (brand) {
      case 'ASUS':
        _brand = 'asus.png';
        break;

      default:
        _brand = null;
        break;
    }
    return _brand;
  }
}
