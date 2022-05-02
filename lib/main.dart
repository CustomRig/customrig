import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/pages/auth_pages/auth_wrapper.dart';
import 'package:customrig/providers/authentication/auth_provider.dart';
import 'package:customrig/providers/build_rig/build_rig_provider.dart';
import 'package:customrig/providers/dashboard/dashboard_provider.dart';
import 'package:customrig/providers/favorite_items/favorite_items_provider.dart';
import 'package:customrig/providers/nav_bar_provider.dart';
import 'package:customrig/providers/product_list/product_list_provider.dart';
import 'package:customrig/providers/product_page/product_page_provider.dart';
import 'package:customrig/providers/user_build/user_build_provider.dart';
import 'package:customrig/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _prefs = await SharedPreferences.getInstance();
  // checking if user is logged in
  runApp(MyApp(
    isUserLoggedIn: _prefs.getString(kUserKey) != null,
  ));
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  const MyApp({Key? key, required this.isUserLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BuildRigProvider()),
        ChangeNotifierProvider(create: (_) => NavbarProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteItemsProvider()),
        ChangeNotifierProvider(create: (_) => UserBuildProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductPageProvider()),
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
      ],
      child: MaterialApp(
        title: 'CustomRig',
        theme: myLightTheme,
        darkTheme: myDarkTheme,
        themeMode: ThemeMode.light,
        home: AuthWrapper(
          isUserLoggedIn: isUserLoggedIn,
        ),
      ),
    );
  }
}
