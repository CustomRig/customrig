import 'package:customrig/utils/color_scheme.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData myLightTheme = ThemeData(
  colorScheme: lightColorScheme,

  // floating action theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    extendedSizeConstraints: const BoxConstraints.tightFor(
      height: 70,
      width: 150,
    ),
    sizeConstraints: const BoxConstraints.tightFor(
      height: 70,
      width: 70,
    ),
    extendedPadding: const EdgeInsets.all(22.0),
    extendedIconLabelSpacing: 16.0,
    shape: const RoundedRectangleBorder(
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

  // navigation bar theme
  navigationBarTheme: NavigationBarThemeData(
    // backgroundColor: lightColorScheme.secondaryContainer,
    indicatorColor: lightColorScheme.primaryContainer,
  ),

  // bottom sheet theme
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
);
