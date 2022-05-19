import 'package:customrig/model/base_item.dart';

abstract class ProductListRepository {
  Future<List<BaseItem>> searchItems({
    required String query,
    required int limit,
    required int offset,
  });
  Future<List<BaseItem>> getItemsByCategory({
    required String category,
    required String type,
    required int limit,
    required int offset,
  });
}
