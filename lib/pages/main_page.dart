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
            body: const HomePage(),
            bottomNavigationBar: NavigationBar(
              selectedIndex: navBar.index,
              onDestinationSelected: (index) {
                navBar.setIndex(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(EvaIcons.homeOutline),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(EvaIcons.heartOutline),
                  label: 'Favorites',
                ),
                NavigationDestination(
                  icon: Icon(EvaIcons.settingsOutline),
                  label: 'My Rigs',
                )
              ],
            ),
            // bottomNavigationBar: GNav(
            //   gap: 8,
            //   color: Colors.grey[800],
            //   activeColor: Colors.purple,
            //   iconSize: 24,
            //   tabMargin: const EdgeInsets.all(10),
            //   tabBackgroundColor: Colors.purple.withOpacity(0.1),
            //   padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            //   selectedIndex: navBar.index,
            //   onTabChange: (index) {
            //     navBar.setIndex(index);
            //   },
            //   tabs: const [
            //     GButton(
            //       icon: EvaIcons.homeOutline,
            //       text: 'Home',
            //     ),
            //     GButton(
            //       icon: EvaIcons.homeOutline,
            //       text: 'Favorites',
            //     ),
            //     GButton(
            //       icon: EvaIcons.homeOutline,
            //       text: 'My Rigs',
            //     ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
