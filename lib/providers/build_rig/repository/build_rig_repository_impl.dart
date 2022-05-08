import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/all_items.dart';
import 'package:customrig/model/rig.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository.dart';
import 'package:customrig/services/user_service.dart';

class BuildRigRepositoryImpl implements BuildRigRepository {
  final UserService _userService = UserService();
  String? _uid;

  @override
  Future<AllItems> getAllItems() async {
    final dio = await MyDio.provideDio();
    final result = await dio.post('/item/getAllItems');
    return AllItems.fromJson(result.data);
  }

  @override
  Future<Rig> buildUserRig({
    required String? title,
    required String? description,
    required int price,
    required List<String>? usage,
    required String? cabinetId,
    required String? processorId,
    required String? motherboardId,
    required String? graphicCardId,
    required String? powerSupplyId,
    required String? storageId,
    required String? ramId,
    required String? coolerId,
    required String? wifiAdapterId,
    required String? operatingSystemId,
  }) async {
    _uid = await _userService.getUserId();

    final dio = await MyDio.provideDio();
    final result = await dio.post('/rig/buildUserRig', data: {
      "uid": _uid,
      "title": title,
      "price": price,
      "description": description,
      "cabinet": cabinetId,
      "processor": processorId,
      "motherboard": motherboardId,
      "graphic_card": graphicCardId,
      "power_supply": powerSupplyId,
      "storage": storageId,
      "ram": ramId,
      "cooler": coolerId,
      "wifi_adapter": wifiAdapterId,
      "operating_system": operatingSystemId,
      "usage": usage,
    });
    return Rig.fromJson(result.data);
  }
}
