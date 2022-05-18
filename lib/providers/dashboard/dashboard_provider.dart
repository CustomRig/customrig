import 'dart:convert';

import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/model/dashboard.dart';
import 'package:customrig/providers/dashboard/repository/dashboard_repository.dart';
import 'package:customrig/providers/dashboard/repository/dashboard_repository_impl.dart';
import 'package:customrig/services/prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum DashboardState { initial, loading, complete, error }

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _repository = DashboardRepositoryImpl();
  final Prefs _prefs = Prefs();
  Dashboard? _dashboard;
  Dashboard? get dashboard => _dashboard;

  DashboardState _state = DashboardState.initial;
  DashboardState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;

  void getDashboard() async {
    if (_dashboard == null) setState(DashboardState.loading);

    try {
      final dashboardFromPrefs = await _getDashboardFromPrefs();

      if (dashboardFromPrefs != null) {
        _dashboard = dashboardFromPrefs;
        notifyListeners();
        setState(DashboardState.complete);

        final _dashboardFromApi = await _repository.getDashboard();
        _dashboard = _dashboardFromApi;
        _refreshController.refreshCompleted();
        _prefs.setString(kDashboard, json.encode(_dashboard));
        notifyListeners();
      } else {
        _dashboard = await _repository.getDashboard();
        _refreshController.refreshCompleted();
        setState(DashboardState.complete);
        _prefs.setString(kDashboard, json.encode(_dashboard));
      }
    } on DioError catch (e) {
      _errorMessage = e.error.toString();
      setState(DashboardState.error);
    }
  }

  setState(DashboardState state) {
    _state = state;
    notifyListeners();
  }

  Future<Dashboard?> _getDashboardFromPrefs() async {
    final dashboardPrefsString = await _prefs.getString(kDashboard);
    if (dashboardPrefsString != null) {
      final dashboardFromPrefs = json.decode(dashboardPrefsString);
      final dashboard = Dashboard.fromJson(dashboardFromPrefs);
      return dashboard;
    } else {
      return null;
    }
  }
}
