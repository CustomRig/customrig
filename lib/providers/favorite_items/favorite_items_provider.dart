import 'package:customrig/model/item.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository_impl.dart';
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

  List<Item> _favoriteItems = [];
  List<Item> get favoriteItems => _favoriteItems;

  Future<List<Item>> getFavoriteItems({required uid}) async {
    setState(FavoriteItemState.loading);
    try {
      _favoriteItems = await _repository.getFavoriteItems();
      setState(FavoriteItemState.complete);
    } on DioError catch (e) {
      setState(FavoriteItemState.error);
      _errorMessage = e.message;
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
      await _repository.removeItemFromFavorite(itemId: itemId);
      notifyListeners();
    } on DioError catch (e) {
      //TODO: handle this if time permits
    }
  }

  void setState(FavoriteItemState state) {
    _state = state;
    notifyListeners();
  }
}
