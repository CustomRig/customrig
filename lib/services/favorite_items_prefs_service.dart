import 'dart:convert';

import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/services/prefs.dart';

import '../model/base_item.dart';

class FavoriteItemsPrefsService {
  final Prefs _prefs = Prefs();

  Future<List<BaseItem>> getFavoriteItems() async {
    final favItemsFromPrefsString = await _prefs.getString(kFavoriteItems);
    if (favItemsFromPrefsString != null) {
      final favItemsFromPrefsJson = json.decode(favItemsFromPrefsString);
      final favItems = favItemsFromPrefsJson
          .map<BaseItem>((item) => BaseItem.fromJson(item))
          .toList();
      return favItems;
    } else {
      return [];
    }
  }

  Future<void> setFavoriteItems(List<BaseItem> items) async {
    await _prefs.setString(kFavoriteItems, json.encode(items));
  }

  void addItemToFavorite(BaseItem item) async {
    final favItems = await getFavoriteItems();
    favItems.add(item);
    setFavoriteItems(favItems);
  }

  Future<void> removeItemFromFavorites(String itemId) async {
    final favItems = await getFavoriteItems();
    favItems.removeWhere((element) => element.id == itemId);
    setFavoriteItems(favItems);
  }

  Future<bool> isItemFavorite(String itemId) async {
    final favItems = await getFavoriteItems();
    return favItems.any((element) => element.id == itemId);
  }
}
