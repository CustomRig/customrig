import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/shimmer_widgets/my_shimmer.dart';
import 'package:flutter/material.dart';

class SmallCardPageShimmer extends StatelessWidget {
  const SmallCardPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: 15,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const MyShimmer(width: 80, height: 80),
                  spacer(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyShimmer(width: 200, height: 12),
                      spacer(height: 6),
                      const MyShimmer(width: 100, height: 12),
                      spacer(height: 22),
                      const MyShimmer(width: 80, height: 12),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
