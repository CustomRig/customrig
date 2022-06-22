import 'package:customrig/pages/auth_pages/login_page.dart';
import 'package:customrig/providers/authentication/auth_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/global_widgets/base_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        children: [
          _profileCard(),
          _appThemeCard(),
        ],
      ),
    );
  }

  List<Widget> _buildDarkModeChips(BuildContext context, ThemeProvider value) {
    List<Widget> choices = [];
    for (var theme in ThemeMode.values) {
      choices.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ChoiceChip(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          selectedColor: Theme.of(context).colorScheme.primary,
          labelStyle: TextStyle(
            color: value.themeMode == theme
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          elevation: 2,
          label: Text(theme.name),
          selected: value.themeMode == theme,
          onSelected: (selected) {
            value.setTheme(theme);
          },
        ),
      ));
    }
    return choices;
  }

  Consumer<AuthProvider> _profileCard() {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      value.getCurrentUser();
      return BaseCard(
        onTap: () {},
        child: Row(
          children: [
            CircleAvatar(
              child: Text(value.user?.email?.substring(0, 1) ?? ''),
            ),
            spacer(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Logged in as',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value.user?.email ?? '',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => value.signOut().then(
                    (value) => pushReplacement(context, const LoginPage()),
                  ),
              child: const Text('LOG OUT'),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                primary: Theme.of(context).colorScheme.error,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _appThemeCard() {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return BaseCard(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'App Theme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              spacer(height: 4),
              Wrap(
                children: _buildDarkModeChips(context, value),
              )
            ],
          ),
        );
      },
    );
  }
}
