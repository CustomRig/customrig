import 'package:customrig/model/dashboard.dart';

abstract class DashboardRepository {
  Future<Dashboard> getDashboard();
}
