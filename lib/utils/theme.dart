import 'package:customrig/utils/color_scheme.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:flutter/material.dart';

ThemeData myLightTheme = ThemeData(
  colorScheme: lightColorScheme,

  scaffoldBackgroundColor: lightColorScheme.background,

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
    backgroundColor: lightColorScheme.background,
    elevation: 0,
    titleTextStyle:
        MyTextStyles.heading.copyWith(color: lightColorScheme.onSurface),
    iconTheme: IconThemeData(
      color: lightColorScheme.onSurface,
    ),
  ),

  // navigation bar theme
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: lightColorScheme.primaryContainer.withOpacity(.5),
    indicatorColor: lightColorScheme.primaryContainer,
  ),

  // bottom sheet theme
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
);

ThemeData myDarkTheme = ThemeData(
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.background,

  // floating action theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
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
    backgroundColor: darkColorScheme.background,
    elevation: 0,
    titleTextStyle:
        MyTextStyles.heading.copyWith(color: darkColorScheme.onSurface),
    iconTheme: IconThemeData(
      color: darkColorScheme.onSurface,
    ),
  ),

  // navigation bar theme
  navigationBarTheme: NavigationBarThemeData(
    // backgroundColor: lightColorScheme.secondaryContainer,
    indicatorColor: darkColorScheme.primaryContainer,
  ),

  // bottom sheet theme
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
);
