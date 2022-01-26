import 'package:customrig/utils/dummy_data.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/cabinet_card_widget.dart';
import 'package:flutter/material.dart';

class SelectCabinet extends StatelessWidget {
  final String selectedCabinet;
  final void Function(String) onSelectedCabinetChanged;
  const SelectCabinet({
    Key? key,
    required this.selectedCabinet,
    required this.onSelectedCabinetChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;

    List cabinets = ['q', 'e', 'r', 't', 'y', 'u', 'i']; // for dummy purpose

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
          itemCount: cabinets.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: CabinetCardWidget(
                title: 'Apple CPU',
                imageUrl: kDummyProductImage,
                price: '12121',
                id: cabinets[index],
                isSelected: selectedCabinet == cabinets[index],
                onTap: () => onSelectedCabinetChanged(cabinets[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}
