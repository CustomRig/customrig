import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/dashboard.dart';
import 'package:customrig/providers/dashboard/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<Dashboard> getDashboard() async {
    final dio = await MyDio.provideDio();
    final result = await dio.post('/dashboard/get');
    return Dashboard.fromJson(result.data);
  }
}
