import 'package:customrig/model/dashboard.dart';
import 'package:customrig/providers/dashboard/repository/dashboard_repository.dart';
import 'package:customrig/providers/dashboard/repository/dashboard_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum DashboardState { initial, loading, complete, error }

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _repository = DashboardRepositoryImpl();

  Dashboard? _dashboard;
  Dashboard? get dashboard => _dashboard;

  DashboardState _state = DashboardState.initial;
  DashboardState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void getDashboard() async {
    try {
      if (_dashboard == null) {
        setState(DashboardState.loading);
        _dashboard = await _repository.getDashboard();
        setState(DashboardState.complete);
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
}
