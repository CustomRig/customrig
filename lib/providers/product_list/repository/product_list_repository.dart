import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';

abstract class ProductListRepository {
  Future<List<Item>> searchItems({required String query});
  Future<List<BaseItem>> getItemsByCategory({
    required String category,
    required String type,
    required int limit,
  });
}
