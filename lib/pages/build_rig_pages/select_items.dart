import 'package:customrig/model/item.dart';
import 'package:customrig/widgets/global_widgets/brand_card.dart';
import 'package:customrig/widgets/global_widgets/build_rig_item_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../utils/helpers.dart';

class SelectItems extends StatefulWidget {
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
  State<SelectItems> createState() => _SelectItemsState();
}

class _SelectItemsState extends State<SelectItems> {
  final _showcaseKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _isFirstLaunch().then((isFirstLaunch) {
            if (isFirstLaunch) {
              ShowCaseWidget.of(context)?.startShowCase([_showcaseKey]);
            }
          });
        });
      },
    );

    super.initState();
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) sharedPreferences.setBool('isFirstLaunch', false);

    return isFirstLaunch;
  }

  @override
  Widget build(BuildContext context) {
    // sorting

    // short on time, please don't judge for this stupid dirty code
    List<Item> sortedItems = widget.items.where((e) {
      return widget.selectedBrand != null
          ? e.brand == widget.selectedBrand
          : true;
    }).where((e) {
      return widget.category != 'PROCESSOR' ||
              widget.category != 'MOTHERBOARD' ||
              widget.category != 'RAM' ||
              widget.category != 'GRAPHIC_CARD'
          ? true
          : widget.usage != null
              ? e.usage!.contains(widget.usage)
              : true;
    }).where((e) {
      return widget.category != 'PROCESSOR' || widget.category == 'MOTHERBOARD'
          ? true
          : widget.pairingIds != null
              ? widget.pairingIds!
                  .any((element) => e.pairingIds!.contains(element))
              : true;
    }).toList();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: Text(
            widget.itemName == 'RAM'
                ? 'Select RAM'
                : 'Select ${widget.itemName.snakeCaseToTitleCase()}',
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
            children: widget.brands
                .map((e) => _buildBrandCard(widget.brands.length, e))
                .toList(),
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
            return index == 0 && widget.category == "PROCESSOR"
                ? Showcase(
                    radius: BorderRadius.circular(12),
                    key: _showcaseKey,
                    description: 'Long press for more details',
                    child: BuildRigItemCard(
                      item: sortedItems[index],
                      isSelected: widget.selectedItem == sortedItems[index],
                      onItemChanged: widget.onItemChanged,
                      showItemDetails: widget.showItemDetails,
                    ),
                  )
                : BuildRigItemCard(
                    item: sortedItems[index],
                    isSelected: widget.selectedItem == sortedItems[index],
                    onItemChanged: widget.onItemChanged,
                    showItemDetails: widget.showItemDetails,
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
      isSelected: brand == widget.selectedBrand,
      onBrandChanged: widget.onBrandChanged,
    );
  }
}
