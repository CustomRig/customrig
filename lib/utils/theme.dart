import 'package:customrig/utils/text_styles.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData myLightTheme = ThemeData(
  primarySwatch: Colors.blue,

  // floating action theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kBlueAccentColor,
    foregroundColor: kBlackColor,
    extendedSizeConstraints: BoxConstraints.tightFor(
      height: 70,
      width: 150,
    ),
    sizeConstraints: BoxConstraints.tightFor(
      height: 70,
      width: 70,
    ),
    extendedPadding: EdgeInsets.all(22.0),
    extendedIconLabelSpacing: 16.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(22),
      ),
    ),
  ),

  // app bar theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: MyTextStyles.heading.copyWith(color: kBlackColor),
    iconTheme: const IconThemeData(
      color: kBlackColor,
    ),
  ),
);
