import 'dart:convert';

import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository_impl.dart';
import 'package:customrig/services/prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum FavoriteItemState {
  initial,
  loading,
  complete,
  error,
}

class FavoriteItemsProvider extends ChangeNotifier {
  final FavoriteItemsRepository _repository = FavoriteItemsRepositoryImpl();

  FavoriteItemState _state = FavoriteItemState.initial;
  FavoriteItemState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final tempItemId = "6251b7daea44221898adb735";
  //TODO: remove temp ids

  final Prefs _prefs = Prefs();

  List<Item> _favoriteItems = [];
  List<Item> get favoriteItems => _favoriteItems;

  Future<List<Item>> getFavoriteItems() async {
    if (_favoriteItems.isEmpty) setState(FavoriteItemState.loading);

    try {
      final itemsFromPrefs = await _getFavItemsFromPrefs();

      if (itemsFromPrefs.isNotEmpty) {
        _favoriteItems = itemsFromPrefs;
        notifyListeners();

        final favItemsFromApi = await _repository.getFavoriteItems();

        if (_favoriteItems.length != favItemsFromApi.length) {
          _favoriteItems = favItemsFromApi;
          _prefs.setString(kFavoriteItems, json.encode(favItemsFromApi));
        }
        setState(FavoriteItemState.complete);
      } else {
        setState(FavoriteItemState.loading);
        _favoriteItems = await _repository.getFavoriteItems();
        _prefs.setString(kFavoriteItems, json.encode(_favoriteItems));
        setState(FavoriteItemState.complete);
      }
    } on DioError catch (e) {
      setState(FavoriteItemState.error);
      _errorMessage = e.response.toString();
    }
    return <Item>[];
  }

  Future<void> addItemToFavorite({
    required String itemId,
    required String uid,
  }) async {
    await _repository.addItemToFavorite(itemId: tempItemId);
  }

  Future<void> removeItemFromFavorite({required String itemId}) async {
    try {
      _favoriteItems.removeWhere((element) => element.id == itemId);
      notifyListeners();
      _prefs.setString(kFavoriteItems, json.encode(_favoriteItems));
      await _repository.removeItemFromFavorite(itemId: itemId);
    } on DioError catch (e) {
      //TODO: handle this if time permits
    }
  }

  void setState(FavoriteItemState state) {
    _state = state;
    notifyListeners();
  }

  Future<List<Item>> _getFavItemsFromPrefs() async {
    final favItemsFromPrefsString = await _prefs.getString(kFavoriteItems);
    if (favItemsFromPrefsString != null) {
      final favItemsFromPrefsJson = json.decode(favItemsFromPrefsString);
      final favItems = favItemsFromPrefsJson
          .map<Item>((item) => Item.fromJson(item))
          .toList();
      print(favItems);
      return favItems;
    } else {
      return [];
    }
  }
}
