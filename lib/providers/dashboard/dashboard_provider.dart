import 'package:customrig/model/dashboard.dart';
import 'package:customrig/providers/dashboard/repository/dashboard_repository.dart';
import 'package:customrig/providers/dashboard/repository/dashboard_repository_impl.dart';
import 'package:flutter/material.dart';

enum DashboardState { initial, loading, complete, error }

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _repository = DashboardRepositoryImpl();

  Dashboard? _dashboard;
  Dashboard? get dashboard => _dashboard;

  DashboardState _state = DashboardState.initial;
  DashboardState get state => _state;

  void getDashboard() async {
    try {
      setState(DashboardState.loading);
      _dashboard = await _repository.getDashboard();

      print(_dashboard!.sections!.length);
      setState(DashboardState.complete);
    } on Exception catch (e) {
      setState(DashboardState.error);
      print(e);
    }
  }

  setState(DashboardState state) {
    _state = state;
    notifyListeners();
  }
}
