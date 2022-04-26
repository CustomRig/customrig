import 'dart:convert';

import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/model/rig.dart';
import 'package:customrig/providers/user_build/repository/user_build_repository.dart';
import 'package:customrig/providers/user_build/repository/user_build_repository_impl.dart';
import 'package:customrig/services/prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum UserBuildState {
  initial,
  loading,
  complete,
  error,
}

class UserBuildProvider extends ChangeNotifier {
  UserBuildRepository _repository = UserBuildRepositoryImpl();

  UserBuildState _state = UserBuildState.initial;
  UserBuildState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<Rig> _userBuilds = [];
  List<Rig> get favoriteItems => _userBuilds;

  final Prefs _prefs = Prefs();

  Future<List<Rig>> getUserBuild() async {
    if (_userBuilds.isEmpty) setState(UserBuildState.loading);

    try {
      final rigsFromPrefs = await _getUserBuildFromPrefs();

      if (rigsFromPrefs.isNotEmpty) {
        _userBuilds = rigsFromPrefs;
        notifyListeners();

        final userBuildsFromApi = await _repository.getUserBuilds();

        if (_userBuilds.length != userBuildsFromApi.length) {
          _userBuilds = userBuildsFromApi;
          _prefs.setString(kUserRigs, json.encode(userBuildsFromApi));
        }

        setState(UserBuildState.complete);
      } else {
        _userBuilds = await _repository.getUserBuilds();
        setState(UserBuildState.complete);
        _prefs.setString(kUserRigs, json.encode(_userBuilds));
      }
    } on DioError catch (e) {
      setState(UserBuildState.error);
      _errorMessage = e.response.toString();
    }
    return <Rig>[];
  }

  Future<void> removeBuild({required String rigId}) async {
    try {
      _userBuilds.removeWhere((element) => element.id == rigId);
      notifyListeners();
      _prefs.setString(kUserRigs, json.encode(_userBuilds));
      await _repository.removeUserBuild(rigId: rigId);
    } on DioError catch (e) {
      //TODO: handle this if time permits
    }
  }

  void setState(UserBuildState state) {
    _state = state;
    notifyListeners();
  }

  Future<List<Rig>> _getUserBuildFromPrefs() async {
    final userRigsFromPrefs = await _prefs.getString(kUserRigs);
    if (userRigsFromPrefs != null) {
      final userRigsJson = json.decode(userRigsFromPrefs);
      final userRigs =
          userRigsJson.map<Rig>((item) => Rig.fromJson(item)).toList();
      return userRigs;
    } else {
      return [];
    }
  }
}
