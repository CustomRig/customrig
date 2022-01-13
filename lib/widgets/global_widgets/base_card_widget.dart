import 'package:customrig/pages/product_page.dart';
import 'package:customrig/utils/colors.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;

  const BaseCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      child: Material(
        elevation: 2.3,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            // Temporary
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductPage()));
          },
          borderRadius: BorderRadius.circular(12.0),
          splashColor: kBlueAccentColor,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
