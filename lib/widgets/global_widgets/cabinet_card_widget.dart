import 'package:customrig/utils/helpers.dart';
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
            fit: BoxFit.fitHeight,
          ),
          border: isSelected
              ? Border.all(
                  width: 6, color: Theme.of(context).colorScheme.primary)
              : null,
        ),

        // For the shadow
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isSelected ? 4.0 : 12.0),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                spacer(height: 6),
                Text(
                  '₹ ' + formatCurrency(price),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
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
