import 'package:customrig/model/item.dart';

abstract class FavoriteItemsRepository {
  Future<void> addItemToFavorite({required String itemId});
  Future<void> removeItemFromFavorite({required String itemId});
  Future<List<Item>> getFavoriteItems();
}
