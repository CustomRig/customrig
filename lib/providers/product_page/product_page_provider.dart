import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository_impl.dart';
import 'package:customrig/services/favorite_items_prefs_service.dart';
import 'package:flutter/material.dart';

class ProductPageProvider extends ChangeNotifier {
  final ProductPageRepository _repository = ProductPageRepositoryImpl();

  final _favItemPrefsService = FavoriteItemsPrefsService();

  Future<bool> addItemToFavorite({required BaseItem item}) async {
    try {
      // _favItemPrefsService.addItemToFavorite(item);
      await _repository.addItemToFavorite(itemId: item.id!);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeItemFromFavorites({required String itemId}) async {
    try {
      _favItemPrefsService.removeItemFromFavorites(itemId);
      await _repository.remoteItemFromFavorite(itemId: itemId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isFavorite(String id) async {
    return await _favItemPrefsService.isItemFavorite(id);
  }
}
