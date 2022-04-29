import 'package:customrig/model/item.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository_impl.dart';
import 'package:customrig/services/favorite_items_prefs_service.dart';
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

  List<Item> _favoriteItems = [];
  List<Item> get favoriteItems => _favoriteItems;

  final _favoriteItemsPrefs = FavoriteItemsPrefsService();

  Future<List<Item>> getFavoriteItems() async {
    // first check if there is data in shared preferences
    // if yes, then show it
    // if no, then fetch from server and show it and add it to the shared preferences
    if (_favoriteItems.isEmpty) setState(FavoriteItemState.loading);

    try {
      final itemsFromPrefs = await _favoriteItemsPrefs.getFavoriteItems();

      if (itemsFromPrefs.isNotEmpty) {
        _favoriteItems = itemsFromPrefs;
        notifyListeners();
        setState(FavoriteItemState.complete);

        final favItemsFromApi = await _repository.getFavoriteItems();

        if (_favoriteItems.length != favItemsFromApi.length) {
          _favoriteItems = favItemsFromApi;
          _favoriteItemsPrefs.setFavoriteItems(favItemsFromApi);
        }
      } else {
        setState(FavoriteItemState.loading);
        _favoriteItems = await _repository.getFavoriteItems();
        _favoriteItemsPrefs.setFavoriteItems(_favoriteItems);
        setState(FavoriteItemState.complete);
      }
    } on DioError catch (e) {
      setState(FavoriteItemState.error);
      _errorMessage = e.response.toString();
    }
    return <Item>[];
  }

  Future<void> removeItemFromFavorite({required String itemId}) async {
    try {
      _favoriteItems.removeWhere((element) => element.id == itemId);
      notifyListeners();
      _favoriteItemsPrefs.removeItemFromFavorites(itemId);
      await _repository.removeItemFromFavorite(itemId: itemId);
    } on DioError catch (e) {
      //TODO: handle this if time permits
    }
  }

  void setState(FavoriteItemState state) {
    _state = state;
    notifyListeners();
  }
}
