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

enum ForgotPasswordState {
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

  TextEditingController _forgotPasswordEmailController =
      TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signupFormKey => _signupFormKey;

  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get forgotPasswordFormKey => _forgotPasswordFormKey;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get forgotPasswordEmailController =>
      _forgotPasswordEmailController;

  final AuthRepository _repository = AuthRepositoryImpl();

  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  ForgotPasswordState _forgotPasswordState = ForgotPasswordState.initial;
  ForgotPasswordState get forgotPasswordState => _forgotPasswordState;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _forgotPasswordMessage = '';
  String get forgotPasswordMessage => _forgotPasswordMessage;

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
        _errorMessage =
            e.response != null ? e.response?.data['err'] : e.message;
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

  Future forgotPassword() async {
    try {
      if (_forgotPasswordFormKey.currentState!.validate()) {
        _setForgotPasswordState(ForgotPasswordState.loading);
        final result = await _repository.forgotPassword(
          email: _forgotPasswordEmailController.text.trim(),
        );

        _forgotPasswordMessage = result;
        _setForgotPasswordState(ForgotPasswordState.complete);
      }
    } on DioError catch (e) {
      _setForgotPasswordState(ForgotPasswordState.error);
      _forgotPasswordMessage =
          e.response != null ? e.response?.data['err'] : e.message;
    }
  }

  disposeProvider() {
    _errorMessage = '';
    _forgotPasswordMessage = '';
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _forgotPasswordEmailController.clear();

    _state = AuthState.initial;
    _forgotPasswordState = ForgotPasswordState.initial;
  }

  initDialogData() {
    if (_emailController.text.isNotEmpty) {
      _forgotPasswordEmailController = _emailController;
    }
    _forgotPasswordState = ForgotPasswordState.initial;
    _forgotPasswordMessage = '';
  }

  _setState(AuthState state) {
    _state = state;
    notifyListeners();
  }

  _setForgotPasswordState(ForgotPasswordState state) {
    _forgotPasswordState = state;
    notifyListeners();
  }
}
