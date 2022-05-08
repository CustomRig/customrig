import 'package:customrig/model/base_item.dart';

abstract class FavoriteItemsRepository {
  Future<void> addItemToFavorite({
    required String itemId,
    required String type,
  });
  Future<void> removeItemFromFavorite({required String itemId});
  Future<List<BaseItem>> getFavoriteItems();
}
