import 'package:customrig/pages/product_list_page.dart';
import 'package:customrig/pages/settings_page.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/global_widgets/my_tile_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onFavoriteClick;
  final VoidCallback onMyRigsClick;
  final bool isHomeSelected;
  final bool isFavoriteSelected;
  final bool isMyRigsSelected;
  const MyDrawer({
    Key? key,
    required this.onHomeClick,
    required this.onFavoriteClick,
    required this.onMyRigsClick,
    required this.isHomeSelected,
    required this.isFavoriteSelected,
    required this.isMyRigsSelected,
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
                style:
                    textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            spacer(height: 6),
            MyTile(
              title: 'Home',
              icon: isHomeSelected ? EvaIcons.home : EvaIcons.homeOutline,
              isSelected: isHomeSelected,
              onClick: () => onHomeClick(),
            ),
            MyTile(
              title: 'Favorites',
              icon: isFavoriteSelected ? EvaIcons.heart : EvaIcons.heartOutline,
              isSelected: isFavoriteSelected,
              onClick: () => onFavoriteClick(),
            ),
            MyTile(
              title: 'My Rigs',
              icon: isMyRigsSelected
                  ? EvaIcons.settings
                  : EvaIcons.settingsOutline,
              isSelected: isMyRigsSelected,
              onClick: () => onMyRigsClick(),
            ),
            spacer(height: 6),
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
            spacer(height: 6),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            spacer(height: 6),
            MyTile(
              title: 'Settings',
              icon: EvaIcons.settingsOutline,
              // isSelected: true,
              onClick: () {
                goToPage(context, const SettingsPage());
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
    bool isSelected = false,
  }) {
    return MyTile(
      title: title,
      icon: icon,
      isSelected: isSelected,
      onClick: () {
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
