import 'package:customrig/model/item.dart';

abstract class ProductListRepository {
  Future<List<Item>> searchItems({required String query});
  Future<List<Item>> getItemsByCategory({required String category});
}
