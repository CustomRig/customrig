import 'package:customrig/model/all_items.dart';
import 'package:customrig/model/rig.dart';

abstract class BuildRigRepository {
  Future<AllItems> getAllItems();
  Future<Rig> buildUserRig({
    required String? title,
    required String? description,
    required int price,
    required String? usage,
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
  });
}
