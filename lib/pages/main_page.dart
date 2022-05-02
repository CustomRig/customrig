import 'package:customrig/model/page.dart';
import 'package:customrig/pages/favorite_page.dart';
import 'package:customrig/pages/home_page.dart';
import 'package:customrig/pages/my_rigs_page.dart';
import 'package:customrig/providers/nav_bar_provider.dart';
import 'package:customrig/widgets/global_widgets/search_deligate.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../widgets/global_widgets/drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<MyPage> pages = [
    MyPage(page: const HomePage(), title: 'CustomRig'),
    MyPage(page: const FavoritePage(), title: 'Favorites'),
    MyPage(page: const MyRigsPage(), title: 'My Rigs'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavbarProvider>(
      builder: (context, navBar, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(pages[navBar.index].title),
            actions: <Widget>[_buildSearchButton(navBar.index)],
          ),
          drawer: MyDrawer(
            onFavoriteClick: () {
              Navigator.pop(context);
              navBar.setIndex(1);
            },
            onMyRigsClick: () {
              Navigator.pop(context);
              navBar.setIndex(2);
            },
          ),
          body: pages[navBar.index].page,
          bottomNavigationBar: NavigationBar(
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
    );
  }

  Widget _buildSearchButton(int index) {
    if (index == 0) {
      return IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: MySearchDelegate(),
          );
        },
        icon: const Icon(Ionicons.search),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
