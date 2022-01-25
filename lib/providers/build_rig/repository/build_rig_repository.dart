import 'package:customrig/model/all_items.dart';

abstract class BuildRigRepository {
  Future<AllItems> getAllItems();
}
