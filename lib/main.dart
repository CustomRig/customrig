import 'package:customrig/pages/main_page.dart';
import 'package:customrig/providers/build_rig/build_rig_provider.dart';
import 'package:customrig/providers/dashboard/dashboard_provider.dart';
import 'package:customrig/providers/favorite_items/favorite_items_provider.dart';
import 'package:customrig/providers/nav_bar_provider.dart';
import 'package:customrig/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BuildRigProvider()),
        ChangeNotifierProvider(create: (_) => NavbarProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteItemsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myLightTheme,
        darkTheme: myLightTheme,
        home: const MainPage(),
      ),
    );
  }
}
