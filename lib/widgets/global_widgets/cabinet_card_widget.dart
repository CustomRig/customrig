import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CabinetCardWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int price;
  final bool isSelected;
  final VoidCallback onTap;
  const CabinetCardWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          border: isSelected
              ? Border.all(
                  width: 6, color: Theme.of(context).colorScheme.primary)
              : null,
        ),

        // For the shadow
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(isSelected ? 0.4 : 0.9),
              ],
              stops: const [0.0, 1.0],
            ),
          ),

          // the actual child
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: MyTextStyles.productTitle.copyWith(
                    color: Colors.white,
                    fontSize: isSelected ? 24.0 : 22.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '₹ ' + formatCurrency(price),
                  style: MyTextStyles.productSubtitle.copyWith(
                    color: Colors.white,
                    fontSize: isSelected ? 18.0 : 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
