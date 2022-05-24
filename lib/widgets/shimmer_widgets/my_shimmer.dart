import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final double width;
  final double height;

  const MyShimmer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkTheme ? Colors.grey[900]! : Colors.grey[100]!,
      highlightColor: isDarkTheme ? Colors.grey[800]! : Colors.grey[300]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDarkTheme ? Colors.black : Colors.white,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
