import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/all_items.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository.dart';

class BuildRigRepositoryImpl implements BuildRigRepository {
  @override
  Future<AllItems> getAllItems() async {
    final dio = await MyDio.provideDio();
    final result = await dio.post('/item/getAllItems');
    return AllItems.fromJson(result.data);
  }
}
