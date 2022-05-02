import 'package:customrig/pages/favorite_page.dart';
import 'package:customrig/pages/product_list_page.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onFavoriteClick;
  final VoidCallback onMyRigsClick;
  const MyDrawer({
    Key? key,
    required this.onFavoriteClick,
    required this.onMyRigsClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'CustomRig',
                style: textTheme.headline6,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Ionicons.heart_outline),
              title: const Text('Favorites'),
              onTap: () => onFavoriteClick(),
            ),
            ListTile(
              leading: const Icon(Ionicons.settings_outline),
              title: const Text('My Rigs'),
              onTap: () => onMyRigsClick(),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Categories',
              ),
            ),
            _buildTile(
              context,
              title: 'Gaming Rigs',
              type: 'RIG',
              value: 'GAMING',
              icon: Ionicons.game_controller_outline,
            ),
            _buildTile(
              context,
              title: 'School Rigs',
              type: 'RIG',
              value: 'SCHOOL',
              icon: Ionicons.school_outline,
            ),
            _buildTile(
              context,
              title: 'Office Rigs',
              type: 'RIG',
              value: 'OFFICE',
              icon: Ionicons.document_outline,
            ),
            _buildTile(
              context,
              title: 'Mouse',
              type: 'ITEM',
              value: 'MOUSE',
              icon: Ionicons.navigate_outline,
            ),
            _buildTile(
              context,
              title: 'Keyboard',
              type: 'ITEM',
              value: 'KEYBOARD',
              icon: Ionicons.keypad_outline,
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              iconColor: Theme.of(context).colorScheme.onSurface,
              leading: const Icon(Ionicons.settings_outline),
              title: const Text('Settings'),
              onTap: () {
                goToPage(context, const FavoritePage());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required String title,
    required String type,
    required String value,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        goToPage(
          context,
          ProductListPage(
            title: title,
            value: value,
            type: type,
          ),
        );
      },
    );
  }
}
