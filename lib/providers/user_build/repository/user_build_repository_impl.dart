import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/rig.dart';
import 'package:customrig/providers/user_build/repository/user_build_repository.dart';
import 'package:customrig/services/user_service.dart';

class UserBuildRepositoryImpl implements UserBuildRepository {
  final UserService _userService = UserService();

  String? _uid;

  @override
  Future<List<Rig>> getUserBuilds() async {
    List<Rig> _userBuildsList = [];

    _uid = await _userService.getUserId();

    final dio = await MyDio.provideDio();
    final result = await dio.post('/user/getBuildRigs', data: {
      "uid": _uid,
    });

    final rigsList = result.data['rigs'] as List;

    for (var rig in rigsList) {
      _userBuildsList.add(Rig.fromJson(rig));
    }

    return _userBuildsList;
  }

  @override
  Future<void> removeUserBuild({required String rigId}) async {
    _uid = await _userService.getUserId();

    final dio = await MyDio.provideDio();
    await dio.post('/rig/removeRigFromUserBuild', data: {
      "uid": _uid,
      "rigId": rigId,
    });
  }
}
