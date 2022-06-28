import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          EvaIcons.alertTriangleOutline,
          size: 28,
        ),
        Text(
          'Something went wrong!',
          style: MyTextStyles.productTitle,
        ),
        Text(
          'Please try again later.',
          style: MyTextStyles.productSubtitle,
        ),
      ],
    ));
  }
}
