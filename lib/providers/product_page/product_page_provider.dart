import 'package:customrig/model/base_item.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository_impl.dart';
import 'package:customrig/services/dynamic_link_service.dart';
import 'package:customrig/services/favorite_items_prefs_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

enum ProductPageState {
  initial,
  loading,
  complete,
  error,
}

class ProductPageProvider extends ChangeNotifier {
  final ProductPageRepository _repository = ProductPageRepositoryImpl();

  final _favItemPrefsService = FavoriteItemsPrefsService();
  final _dynamicLink = DynamicLinkService();
  ProductPageState _state = ProductPageState.initial;
  ProductPageState get state => _state;

  BaseItem? _product;
  BaseItem? get product => _product;

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

  Future<void> shareProduct(BaseItem item) async {
    final link = await _dynamicLink.createDynamicLink(item.id!, item.type!);
    Share.share(link, subject: item.title);
  }

  Future<void> loadProduct(
    BaseItem? product, {
    required String? itemId,
    required String? type,
  }) async {
    if (product == null) {
      // from dynamic link
      try {
        _setState(ProductPageState.loading);
        final fetchedProduct =
            await _repository.getProduct(itemId!, type: type!);
        _product = fetchedProduct;
        notifyListeners();
        _setState(ProductPageState.complete);
      } on DioError catch (_) {
        _setState(ProductPageState.error);
      }
    } else {
      // from local product object
      _product = product;
      notifyListeners();
    }
  }

  void _setState(ProductPageState state) {
    _state = state;
    notifyListeners();
  }
}
