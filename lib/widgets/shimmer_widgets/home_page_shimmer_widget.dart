import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/global_widgets/my_horizontal_list.dart';
import 'package:customrig/widgets/shimmer_widgets/my_shimmer.dart';
import 'package:flutter/material.dart';

class HomePageShimmer extends StatelessWidget {
  final bool removeTitle;
  const HomePageShimmer({
    Key? key,
    this.removeTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(6.0),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _section(screenDimension),
        _section(screenDimension),
        _section(screenDimension),
      ],
    );
  }

  Column _section(Size screenDimension) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !removeTitle
            ? const Padding(
                padding: EdgeInsets.all(12.0),
                child: MyShimmer(
                  width: 100,
                  height: 12,
                ),
              )
            : const SizedBox.shrink(),
        MyHorizontalList(
          items: [
            _product(screenDimension),
            spacer(width: 12),
            _product(screenDimension),
            spacer(width: 12),
            _product(screenDimension),
          ],
        ),
        spacer(height: 12),
      ],
    );
  }

  Column _product(Size screenDimension) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyShimmer(
          width: screenDimension.width * 0.35,
          height: 130,
        ),
        spacer(height: 6),
        const MyShimmer(
          width: 100,
          height: 12,
        ),
        spacer(height: 6),
        const MyShimmer(
          width: 50,
          height: 12,
        ),
      ],
    );
  }
}
