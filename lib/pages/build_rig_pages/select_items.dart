import 'package:customrig/model/item.dart';
import 'package:customrig/widgets/global_widgets/brand_card.dart';
import 'package:customrig/widgets/global_widgets/build_rig_item_card.dart';
import 'package:flutter/material.dart';
import '../../utils/helpers.dart';

class SelectItems extends StatelessWidget {
  final String itemName;
  final List<Item> items;
  final List<String> brands;
  final String? selectedBrand;
  final Item? selectedItem;
  final List<String>? pairingIds;
  final String? usage;
  final String? category;

  final void Function(String) onBrandChanged;
  final void Function(Item) onItemChanged;
  final void Function(Item) showItemDetails;

  const SelectItems({
    Key? key,
    required this.brands,
    required this.itemName,
    required this.items,
    this.selectedBrand,
    this.selectedItem,
    required this.onBrandChanged,
    required this.onItemChanged,
    required this.showItemDetails,
    this.pairingIds,
    required this.usage,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // sorting

    // short on time, please don't judge for this stupid dirty code
    List<Item> sortedItems = items.where((e) {
      return selectedBrand != null ? e.brand == selectedBrand : true;
    }).where((e) {
      print(category);
      return category == 'WIFI_ADAPTER' ||
              category == 'OPERATING_SYSTEM' ||
              category == 'POWER_SUPPLY' ||
              category == 'STORAGE'
          ? true
          : usage != null
              ? e.usage!.contains(usage)
              : true;
    }).where((e) {
      return category == 'PROCESSOR' ||
              category == 'WIFI_ADAPTER' ||
              category == 'OPERATING_SYSTEM' ||
              category == 'POWER_SUPPLY' ||
              category == 'STORAGE'
          ? true
          : pairingIds != null
              ? pairingIds!.any((element) => e.pairingIds!.contains(element))
              : true;
    }).toList();

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

        // brands
        const Padding(
          padding: EdgeInsets.only(left: 12.0, top: 12.0),
          child: Text(
            'Brand',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Wrap(
            children:
                brands.map((e) => _buildBrandCard(brands.length, e)).toList(),
          ),
        ),

        // items
        const Padding(
          padding: EdgeInsets.only(left: 12.0, top: 12.0),
          child: Text(
            'Products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildProductsGrid(sortedItems),
      ],
    );
  }

  Widget _buildProductsGrid(List<Item> sortedItems) {
    if (sortedItems.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: GridView.builder(
          itemCount: sortedItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2 / 1.5),
          itemBuilder: (context, index) {
            return BuildRigItemCard(
              item: sortedItems[index],
              isSelected: selectedItem == sortedItems[index],
              onItemChanged: onItemChanged,
              showItemDetails: showItemDetails,
            );
          },
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          spacer(height: 44),
          const Center(
            child: Text('No products to show!'),
          ),
        ],
      );
    }
  }

  Widget _buildBrandCard(int brandsLength, String brand) {
    return BrandCard(
      brandsLength: brandsLength,
      brand: brand,
      isSelected: brand == selectedBrand,
      onBrandChanged: onBrandChanged,
    );
  }
}
