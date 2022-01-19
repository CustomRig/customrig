import 'dart:ui';

import 'package:customrig/utils/colors.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:flutter/material.dart';

class SelectUsage extends StatelessWidget {
  const SelectUsage({
    Key? key,
    required this.selectedUsage,
    required this.onSelectedUsageChanged,
  }) : super(key: key);

  final String selectedUsage;
  final void Function(String) onSelectedUsageChanged;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(12.0),
      physics: const BouncingScrollPhysics(),
      children: [
        const Text(
          'Select Usage Type',
          style: MyTextStyles.heading,
        ),
        spacer(height: 12.0),
        _usageContainer(
          screenSize,
          asset: 'usage_gaming.jpeg',
          title: 'GAMING',
        ),
        spacer(height: 8.0),
        _usageContainer(
          screenSize,
          asset: 'usage_college.jpeg',
          title: 'COLLEGE',
        ),
        spacer(height: 8.0),
        _usageContainer(
          screenSize,
          asset: 'usage_office.jpeg',
          title: 'OFFICE',
        ),
      ],
    );
  }

  Widget _usageContainer(Size screenSize,
      {required String title, required String asset}) {
    return GestureDetector(
      onTap: () => onSelectedUsageChanged(title),
      child: Container(
        height: screenSize.height * .25,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('assets/images/' + asset),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: screenSize.height * .25,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: selectedUsage == title
                  ? Border.all(width: 6, color: Colors.blueAccent)
                  : null,
              borderRadius: BorderRadius.circular(12),
              color: selectedUsage == title
                  ? kBlackColor.withOpacity(.3)
                  : kBlackColor.withOpacity(.6),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: selectedUsage == title ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
