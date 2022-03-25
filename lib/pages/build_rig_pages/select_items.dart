import 'package:customrig/model/item.dart';
import 'package:flutter/material.dart';
import '../../utils/helpers.dart';

class SelectItems extends StatelessWidget {
  final String itemName;
  final List<Item> items;
  final List<String> brands;
  final String selectedBrand;
  final Item selectedItem;
  const SelectItems({
    Key? key,
    required this.brands,
    required this.itemName,
    required this.items,
    required this.selectedBrand,
    required this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: Text(
            'Select ${itemName.snakeCaseToTitleCase()}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12.0, top: 12.0),
          child: Text(
            'Brand',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Wrap(
              children: brands
                  .map((e) => _buildBrandCard(brands.length, e))
                  .toList()),
        )
      ],
    );
  }

  Widget _buildBrandCard(int brandsLength, String brand) {
    return BrandCard(
      brandsLength: brandsLength,
      brand: brand,
    );
  }
}

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key? key,
    required this.brandsLength,
    required this.brand,
  }) : super(key: key);

  final int brandsLength;
  final String brand;

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
      child: Material(
        elevation: 2.3,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image:
                  AssetImage('assets/images/brands/' + _getBrandImage(brand)),
              fit: BoxFit.fill,
            ),
          ),
          height: screenSize.width * calculatedSizeForCard,
          width: screenSize.width * calculatedSizeForCard,
        ),
      ),
    );
  }

  String _getBrandImage(String brand) {
    String _brand;
    switch (brand) {
      case 'ASUS':
        _brand = 'asus.png';
        break;

      default:
        _brand = 'asus.png';
        break;
    }
    return _brand;
  }
}
