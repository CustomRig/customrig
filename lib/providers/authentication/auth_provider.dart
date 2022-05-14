import 'dart:convert';

import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/model/user.dart';
import 'package:customrig/providers/authentication/repository/auth_repository.dart';
import 'package:customrig/providers/authentication/repository/auth_repository_impl.dart';
import 'package:customrig/services/prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum AuthState {
  initial,
  loading,
  complete,
  error,
}

class AuthProvider extends ChangeNotifier {
  final Prefs _prefs = Prefs();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signupFormKey => _signupFormKey;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  final AuthRepository _repository = AuthRepositoryImpl();

  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  User? _user;
  User? get user => _user;

  Future<User?> getCurrentUser() async {
    final userFromPrefs = await _prefs.getString(kUserKey);
    if (userFromPrefs != null) {
      final user = User.fromJson(json.decode(userFromPrefs));
      _user = user;
      notifyListeners();
      return user;
    } else {
      return null;
    }
  }

  Future<void> handleLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      _errorMessage = '';
      _setState(AuthState.loading);
      try {
        final user = await _repository.logIn(
          _emailController.text.trim(),
          _passwordController.text,
        );
        _user = user;
        _prefs.clearPrefs(kUserKey);
        await _prefs.setString(kUserKey, json.encode(user));
        _setState(AuthState.complete);
      } on DioError catch (e) {
        _errorMessage = e.response!.data['err'];
        _setState(AuthState.error);
      }
    }
  }

  Future<void> handleSignUp() async {
    if (_signupFormKey.currentState!.validate()) {
      _errorMessage = '';
      _setState(AuthState.loading);
      try {
        final user = await _repository.signUp(
          _emailController.text.trim(),
          _passwordController.text,
        );

        _prefs.clearPrefs(kUserKey);
        await _prefs.setString(kUserKey, json.encode(user));
        _setState(AuthState.complete);
      } on DioError catch (e) {
        _errorMessage = e.response!.data['err'];
        _setState(AuthState.error);
      }
    }
  }

  Future<void> signOut() async {
    _prefs.clearPrefs(kUserKey);
    _prefs.clearPrefs(kFavoriteItems);
    _prefs.clearPrefs(kBuildRigItems);
  }

  disposeProvider() {
    _errorMessage = '';
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  _setState(AuthState state) {
    _state = state;
    notifyListeners();
  }
}
