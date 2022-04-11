import 'package:customrig/model/rig.dart';
import 'package:customrig/providers/user_build/repository/user_build_repository.dart';
import 'package:customrig/providers/user_build/repository/user_build_repository_impl.dart';
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

  Future<List<Rig>> getUserBuild() async {
    setState(UserBuildState.loading);
    try {
      _userBuilds = await _repository.getUserBuilds();
      setState(UserBuildState.complete);
    } on DioError catch (e) {
      setState(UserBuildState.error);
      _errorMessage = e.message;
    }
    return <Rig>[];
  }

  Future<void> removeBuild({required String rigId}) async {
    try {
      _userBuilds.removeWhere((element) => element.id == rigId);
      await _repository.removeUserBuild(rigId: rigId);
      notifyListeners();
    } on DioError catch (e) {
      //TODO: handle this if time permits
      print(e);
    }
  }

  void setState(UserBuildState state) {
    _state = state;
    notifyListeners();
  }
}
