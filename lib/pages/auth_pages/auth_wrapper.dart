import 'package:customrig/pages/auth_pages/login_page.dart';
import 'package:customrig/pages/main_page.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  final bool isUserLoggedIn;
  const AuthWrapper({Key? key, required this.isUserLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isUserLoggedIn) {
      return const MainPage();
    } else {
      return const LoginPage();
    }
  }
}
