import 'package:customrig/model/rig.dart';

abstract class UserBuildRepository {
  Future<List<Rig>> getUserBuilds();
  Future<void> removeUserBuild({required String rigId});
}
