import 'package:customrig/model/item.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/cabinet_card_widget.dart';
import 'package:flutter/material.dart';

class SelectCabinet extends StatelessWidget {
  final List<Item> cabinets;
  final void Function(Item) onSelectedCabinetChanged;
  final Item? selectedCabinet;
  final String? usage;
  const SelectCabinet({
    Key? key,
    required this.onSelectedCabinetChanged,
    required this.cabinets,
    required this.selectedCabinet,
    required this.usage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;

    List<Item> sortedCabinets = cabinets.where((e) {
      return usage != null ? e.usage!.contains(usage) : true;
    }).toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, top: 4.0),
          child: Text(
            'Select Cabinet',
            style: MyTextStyles.heading,
          ),
        ),
        spacer(height: 8.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                screenDimension.width / (screenDimension.height / 1.6),
          ),
          itemCount: sortedCabinets.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: CabinetCardWidget(
                title: sortedCabinets[index].title!,
                imageUrl: sortedCabinets[index].imageUrl!,
                price: sortedCabinets[index].price!,
                isSelected: selectedCabinet != null
                    ? sortedCabinets[index].id == selectedCabinet!.id!
                    : false,
                onTap: () => onSelectedCabinetChanged(sortedCabinets[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}
