import 'package:customrig/pages/home_page.dart';
import 'package:customrig/providers/nav_bar_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavbarProvider(),
      child: Consumer<NavbarProvider>(
        builder: (context, navBar, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Custom Rig'),
            ),
            drawer: const Drawer(),
            body: const HomePage(),
            bottomNavigationBar: NavigationBar(
              backgroundColor: const Color(0xFFf1f5fb),
              selectedIndex: navBar.index,
              onDestinationSelected: (index) {
                navBar.setIndex(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(EvaIcons.homeOutline),
                  label: 'Home',
                  selectedIcon: Icon(EvaIcons.home),
                ),
                NavigationDestination(
                  icon: Icon(EvaIcons.heartOutline),
                  label: 'Favorites',
                  selectedIcon: Icon(EvaIcons.heart),
                ),
                NavigationDestination(
                  icon: Icon(EvaIcons.settingsOutline),
                  label: 'My Rigs',
                  selectedIcon: Icon(EvaIcons.settings),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
